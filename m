Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVCBQYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVCBQYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVCBQYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:24:07 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:35081 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262165AbVCBQYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:24:05 -0500
Message-Id: <200503021842.j22IgIBY012680@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Kristian =?iso-8859-1?q?S=F8rensen?= <ks@cs.aau.dk>
cc: Christophe Lucas <clucas@rotomalug.org>, linux-kernel@vger.kernel.org
Subject: Re: UserMode bug in 2.6.11-rc5? autolearn=disabled version=3.0.2 
In-Reply-To: Your message of "Wed, 02 Mar 2005 14:59:39 +0100."
             <200503021459.39846.ks@cs.aau.dk> 
References: <200503021236.26561.ks@cs.aau.dk> <20050302134533.GE13075@rhum.iomeda.fr>  <200503021459.39846.ks@cs.aau.dk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Mar 2005 13:42:18 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ks@cs.aau.dk said:
> Hey! Thanks - that fixed the problem! :-D 

Didn't you say this this setup worked with 2.6.10?  That's why I didn't suggest
staring at /etc/inittab.

				Jeff

