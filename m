Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbUKEDPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUKEDPr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 22:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbUKEDPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 22:15:47 -0500
Received: from [12.177.129.25] ([12.177.129.25]:53699 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262586AbUKEDO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 22:14:57 -0500
Message-Id: <200411050526.iA55QZDZ007751@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
cc: blaisorblade_spam@yahoo.it, linux-kernel@vger.kernel.org,
       user-mode-linux-user@lists.sourceforge.net
Subject: Re: [PATCH] extend the limits for command line 
In-Reply-To: Your message of "Thu, 04 Nov 2004 09:08:57 +0200."
             <Pine.LNX.4.61.0411040859130.18123@webhosting.rdsbv.ro> 
References: <Pine.LNX.4.61.0411040859130.18123@webhosting.rdsbv.ro> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Nov 2004 00:26:35 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

util@deuroconsult.ro said:
> Patch to extend the limits (buffer and number of args/envs) is
> attached. Please consider including it because UML is intended to be
> run with such  long lines. 

I don't have a problem with this either.  The init/main.c piece needs to be
run through LKML, and so far I haven't seen any reaction.

				Jeff

