Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268472AbRGXVhI>; Tue, 24 Jul 2001 17:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268474AbRGXVg6>; Tue, 24 Jul 2001 17:36:58 -0400
Received: from mailout1-hme0.midsouth.rr.com ([24.165.200.10]:25032 "EHLO
	mailout1-hme0.midsouth.rr.com") by vger.kernel.org with ESMTP
	id <S268472AbRGXVgp>; Tue, 24 Jul 2001 17:36:45 -0400
Subject: Re: Newbie problem
From: "Stephen M. Williams" <rootusr@midsouth.rr.com>
To: Frank Akujobi <bulggie@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010724211726.33706.qmail@web12307.mail.yahoo.com>
In-Reply-To: <20010724211726.33706.qmail@web12307.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.11.99 (Preview Release)
Date: 24 Jul 2001 16:36:06 -0500
Message-Id: <996010573.3017.12.camel@bofumgw.bofum.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On 24 Jul 2001 22:17:26 +0100, Frank Akujobi wrote:
> Hi all,
> Am a newbie and this is my first post. I just
> installed Redhat7.1 (one I downloaded) and it's
> working well even hooked it up to the internet. I
> checked my /usr/src/ and I don't find a /linux
> directory. I find only one directory... /redhat. It
> there something wrong somewhere, or do I have to
> download a kernel source seperately. Doing uname -r
> shows me that I have 2.4.x.x.
> 
> Thanks.
> Frank.
> 

OT, but if you did not tell the installer to install the
source/development part, it doesn't install the kernel source.  Look on
your CD or in the directory you downloaded files into for the RPM with
the word kernel-source in them.

The soure can be had from ftp.kernel.org, then untar it into /usr/src.

HTH,
--
Stephen Williams
mailto:rootusr@midsouth.rr.com

* I've tried killing time, but it keeps making a comeback.

