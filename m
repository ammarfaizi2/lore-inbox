Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUAME5a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 23:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbUAME5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 23:57:30 -0500
Received: from [12.177.129.25] ([12.177.129.25]:10948 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S263564AbUAME53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 23:57:29 -0500
Message-Id: <200401130518.i0D5ITS4026863@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: uml-patch-2.6.0 
In-Reply-To: Your message of "Tue, 13 Jan 2004 00:05:33 EST."
             <200401130505.i0D55XS4026774@ccure.user-mode-linux.org> 
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Jan 2004 00:18:29 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch updates UML to 2.6.0 and pulls in all the changes that have
>  accumulated in my 2.4 tree. 

I forgot to mention that newer libcs won't boot on 2.6 UMLs until I get
[gs]et_thread_area implemented.  Older libcs are fine, as are new libcs on
2.4 UMLs.

				Jeff

