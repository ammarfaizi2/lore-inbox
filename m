Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVCKWTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVCKWTF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVCKWTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:19:04 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:33806 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261760AbVCKWRp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:17:45 -0500
Message-Id: <200503120041.j2C0fdJp005353@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 5/9] UML - change semaphores to completions 
In-Reply-To: Your message of "Wed, 09 Mar 2005 16:51:22 PST."
             <20050309165122.47221983.akpm@osdl.org> 
References: <200503100216.j2A2G6DN015238@ccure.user-mode-linux.org>  <20050309165122.47221983.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 Mar 2005 19:41:39 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org said:
> >  + 
> >  +	init_completion(&port->done), 
> >  +
> 
> I'll convert that to a semicolon...

Gawd, thanks...

		Jeff

