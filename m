Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271146AbTHLQ4g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 12:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271148AbTHLQ4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 12:56:36 -0400
Received: from dsl017-022-215.chi1.dsl.speakeasy.net ([69.17.22.215]:30470
	"EHLO gateway.two14.net") by vger.kernel.org with ESMTP
	id S271146AbTHLQ4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 12:56:33 -0400
Date: Tue, 12 Aug 2003 11:56:24 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: maney@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-rc2 ext2 filesystem corruption
Message-ID: <20030812165624.GA1070@furrr.two14.net>
Reply-To: maney@pobox.com
References: <20030812134221.GA6412@furrr.two14.net> <Pine.LNX.4.44.0308121109530.5995-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308121109530.5995-100000@logos.cnet>
User-Agent: Mutt/1.3.28i
From: maney@two14.net (Martin Maney)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 11:10:51AM -0300, Marcelo Tosatti wrote:
> I'll try to reproduce around here. In the meantime can you try to isolate 
> the corruption. You said it didnt happen with 2.4.21 -- which pre shows up 
> the problem? 

The problem appears only in rc2 (okay, assuming it's not a
regression).  With 2.4.21-rc1 the file corruption I've been seeing does
not happen.  From what Stephan has said I think I should try some more
varied tests.  At this point I plan to do that a little later; I will
also try an rc2 with unnecessary features omitted from the build.  So
far I've stayed with the base config, but it's a config shared by most
of the machines on the LAN and thus has plenty of extras.

-- 
Self-pity can make one weep, as can onions.  -- Fodor

