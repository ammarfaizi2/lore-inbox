Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWJGShK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWJGShK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 14:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbWJGShJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 14:37:09 -0400
Received: from ns1.mvista.com ([63.81.120.158]:28924 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751796AbWJGShH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 14:37:07 -0400
Subject: Re: [PATCH 2 of 23] lookup_one_len_nd - lookup_one_len with
	nameidata argument
From: Daniel Walker <dwalker@mvista.com>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk
In-Reply-To: <20061007182301.GA25352@filer.fsl.cs.sunysb.edu>
References: <3104d077379c19c98510.1160197641@thor.fsl.cs.sunysb.edu>
	 <1160240633.21411.6.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20061007182301.GA25352@filer.fsl.cs.sunysb.edu>
Content-Type: text/plain
Date: Sat, 07 Oct 2006 11:37:04 -0700
Message-Id: <1160246224.21411.10.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-07 at 14:23 -0400, Josef Sipek wrote:

> > 
> > These lines are all too long . Should max out at 80 characters.
> 
> A large portion of that file has lines >80 chars. I just kept it consistent.
> 

It's like that all over the kernel, but when you add new code it's good
to keep the lines under <=80 characters. That way you don't add to the
mess.

Daniel

