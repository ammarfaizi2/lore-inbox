Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbUCPP0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbUCPP0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 10:26:08 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:50073 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S262611AbUCPPZn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 10:25:43 -0500
Date: Tue, 16 Mar 2004 08:25:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Cc: Colin Leroy <colin@colino.net>, "David S. Miller" <davem@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torvalds@osdl.org
Subject: Re: [SPARC64][PPC] strange error ..
Message-ID: <20040316152540.GG14221@smtp.west.cox.net>
References: <Pine.LNX.4.58L.0403151437360.16193@alpha.zarz.agh.edu.pl> <Pine.LNX.4.58L.0403151939460.17732@alpha.zarz.agh.edu.pl> <20040315190026.GG4342@smtp.west.cox.net> <20040315123953.3b6b863f.davem@redhat.com> <20040315230220.3f35fd48@jack.colino.net> <Pine.LNX.4.58L.0403160928530.23289@alpha.zarz.agh.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0403160928530.23289@alpha.zarz.agh.edu.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 09:35:36AM +0100, Wojciech 'Sas' Cieciwa wrote:

> 
> 2.6.5-rc1 released and problem still exist on PPC.

Andrew has submitted my preferred fix for PPC32 to Linus, so it should be
in -rc2.

-- 
Tom Rini
http://gate.crashing.org/~trini/
