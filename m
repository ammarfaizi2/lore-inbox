Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVEBOzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVEBOzN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 10:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVEBOzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 10:55:13 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:27908 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261295AbVEBOzK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 10:55:10 -0400
Message-Id: <200505021450.j42EoSWQ004239@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/22] UML - Cross-build support : mk_ptregs 
In-Reply-To: Your message of "Sun, 01 May 2005 23:06:23 BST."
             <20050501220623.GJ13052@parcelfarce.linux.theplanet.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 May 2005 10:50:28 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk said:
> ... and after that patch should be mk_sc conversion.  

Correct, my apologies.  This is being sent now.

> Another missing bit
> (OTOH, that one might be in -mm already) is removal of -L/usr/lib in the 

That's already there.

				Jeff

