Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265839AbUAUQB6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 11:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265728AbUAUQB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 11:01:58 -0500
Received: from pooh.lsc.hu ([195.56.172.131]:12230 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S265526AbUAUQBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 11:01:51 -0500
Date: Wed, 21 Jan 2004 16:46:27 +0100
From: GCS <gcs@lsc.hu>
To: Catalin BOIE <util@deuroconsult.ro>
Cc: Valdis Kletnieks <valdis@turing-police.cc.vt.edu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 2.6.1-mm5 - oops during network initialization
Message-ID: <20040121154627.GB10508@lsc.hu>
References: <20040120000535.7fb8e683.akpm@osdl.org> <200401210638.i0L6cpeU003057@turing-police.cc.vt.edu> <Pine.LNX.4.58.0401211024520.28511@hosting.rdsbv.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401211024520.28511@hosting.rdsbv.ro>
X-Operating-System: GNU/Linux
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 10:31:23AM +0200, Catalin BOIE <util@deuroconsult.ro> wrote:
> On Wed, 21 Jan 2004, Valdis Kletnieks wrote:
> 
> I can confirm I get this also.
> > CONFIG_IPV6_PRIVACY=y
 Can you both try it without the above? At least it's solved my problem, and
I can have 'CONFIG_IPV6=y' and ipv6 netfilter options as modules.

Hope this helps,
GCS
