Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVCBObW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVCBObW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 09:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVCBO3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 09:29:07 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:55559 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262312AbVCBOZK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 09:25:10 -0500
Message-Id: <200503021626.j22GQPBY002226@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Kristian =?iso-8859-1?q?S=F8rensen?= <ks@cs.aau.dk>
cc: linux-kernel@vger.kernel.org, jdike@ccure.user-mode-linux.org
Subject: Re: UserMode bug in 2.6.11-rc5? 
In-Reply-To: Your message of "Wed, 02 Mar 2005 12:36:26 +0100."
             <200503021236.26561.ks@cs.aau.dk> 
References: <200503021236.26561.ks@cs.aau.dk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Mar 2005 11:26:25 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ks@cs.aau.dk said:
> I've just tried usermode Linux with a 2.6.11-rc5 kernel. My kernel
> boots, but  when the shell is to be spawned it freezes: 

Can you try narrowing the problem down?  Start with the 2.6.11-rcx patches
to figure out what -rc broke, and then start figuring out which patch caused
the problem?

				Jeff

