Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267721AbUBTAWU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267634AbUBTAUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:20:07 -0500
Received: from dp.samba.org ([66.70.73.150]:61414 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267595AbUBTAQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:16:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16437.20949.701574.932001@samba.org>
Date: Fri, 20 Feb 2004 11:16:21 +1100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
In-Reply-To: <Pine.LNX.4.58.0402191549500.2244@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402181422180.2686@home.osdl.org>
	<Pine.LNX.4.58.0402181427230.2686@home.osdl.org>
	<16435.60448.70856.791580@samba.org>
	<Pine.LNX.4.58.0402181457470.18038@home.osdl.org>
	<16435.61622.732939.135127@samba.org>
	<Pine.LNX.4.58.0402181511420.18038@home.osdl.org>
	<20040219081027.GB4113@mail.shareable.org>
	<Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
	<20040219163838.GC2308@mail.shareable.org>
	<Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
	<20040219182948.GA3414@mail.shareable.org>
	<Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
	<16437.18605.71269.750607@samba.org>
	<Pine.LNX.4.58.0402191549500.2244@ppc970.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

 > And I've told you OVER AND OVER again that you have a choice: better than 
 > what you do now, or nothing. Whining about the fact that Windows is 
 > stupid will only make me convinced that there is no point to even helping 
 > samba, since what you really want is WNT.

yes, I've acknowledged that. I know you aren't going to give me the
ideal solution, I'm just exploring how far this is from the ideal and
trying to get a feel for how much it actually gains us compared to
what we do now. 

If I understand things correctly then I think that your suggestion
probably does gain us a fair bit, but I think that biting my head off
for exploring just how much the gain is versus the current code and
the "ideal" code is a bit much.

Cheers, Tridge
