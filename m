Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVA3W4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVA3W4E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 17:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVA3W4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 17:56:04 -0500
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:3743 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261825AbVA3W4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 17:56:01 -0500
Message-Id: <200501302255.j0UMtmql020002@ginger.cmf.nrl.navy.mil>
To: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
cc: Mike Westall <westall@cs.clemson.edu>,
       linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Bartlomiej Solarz <solarz@wsisiz.edu.pl>
Reply-To: chas3@users.sourceforge.net
Reply-To: chas3@users.sourceforge.net
Subject: Re: [Linux-ATM-General] Kernel 2.6.10 and 2.4.29 Oops fore200e (fwd) 
In-reply-to: Your message of "Sun, 30 Jan 2005 20:24:10 +0100."
             <Pine.LNX.4.61L.0501302022470.5761@oceanic.wsisiz.edu.pl> 
Date: Sun, 30 Jan 2005 17:55:49 -0500
From: "chas williams - CONTRACTOR" <chas@cmf.nrl.navy.mil>
X-Spam-Score: (*) hits=1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.61L.0501302022470.5761@oceanic.wsisiz.edu.pl>,Lukasz Trabinski writes:
>OK, I think that dirver works much better with udelay() function.

good to hear.  what does atmdiag say about that interface?  does it have 
a large percentage of tx drops?
