Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265575AbRGCHSy>; Tue, 3 Jul 2001 03:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265574AbRGCHSe>; Tue, 3 Jul 2001 03:18:34 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:52834 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S265554AbRGCHSZ>;
	Tue, 3 Jul 2001 03:18:25 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: modules and 2.5 
In-Reply-To: Your message of "Tue, 03 Jul 2001 01:13:45 -0400."
             <3B415489.77425364@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jul 2001 17:18:20 +1000
Message-ID: <2144.994144700@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jul 2001 01:13:45 -0400, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>A couple things that would be nice for 2.5 is
>- let MOD_INC_USE_COUNT work even when module is built into kernel, and
>- let THIS_MODULE exist and be valid even when module is built into
>kernel

There is already a list of module related changes that would be nice
for 2.5.  I have added this one to the list, but don't expect it until
September at least, after I get 2.5 module versions working.

