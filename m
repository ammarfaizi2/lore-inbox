Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271195AbUJVCMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271195AbUJVCMu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 22:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271193AbUJVCMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 22:12:48 -0400
Received: from [12.177.129.25] ([12.177.129.25]:64195 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S271200AbUJVCKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 22:10:36 -0400
Message-Id: <200410220319.i9M3JoFL007324@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Andrew Morton <akpm@osdl.org>
cc: Martin Waitz <tali@admingilde.org>, linux-kernel@vger.kernel.org,
       "blaisorblade_spam@yahoo.it" <blaisorblade_spam@yahoo.it>
Subject: Re: generic hardirq handling for uml 
In-Reply-To: Your message of "Wed, 20 Oct 2004 15:41:05 PDT."
             <20041020154105.7baa5166.akpm@osdl.org> 
References: <20041020001124.GA29215@admingilde.org>  <20041020154105.7baa5166.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Oct 2004 23:19:50 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org said:
> OK, I'll add this to 2.6.9-mm1 (which appears to be a few days off
> yet).  If nobody complains, it goes in.  Thanks. 

It's pretty good.  I've got it in my tree with a few changes which I'll 
send you when I start dealing with -mm again.

				Jeff

