Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129119AbRBORqh>; Thu, 15 Feb 2001 12:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129159AbRBORq2>; Thu, 15 Feb 2001 12:46:28 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:8456 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S129119AbRBORqX>; Thu, 15 Feb 2001 12:46:23 -0500
Date: Thu, 15 Feb 2001 12:46:19 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.1ac12 mkdep -I support - take 2
In-Reply-To: <Pine.LNX.4.33.0102151122360.15924-100000@fonzie.nine.com>
Message-ID: <Pine.LNX.4.33.0102151228010.812-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2001, Pavel Roskin wrote:

> Hello, Keith!
>
> You patch has been applied to 2.4.1ac13, but it doesn't help:

It's fixed in ac14. I ran twice

make depend && make clean && make bzImage && make modules

and it worked both times. Thanks!

Regards,
Pavel Roskin

