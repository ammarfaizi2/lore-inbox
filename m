Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130029AbRB1A3v>; Tue, 27 Feb 2001 19:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130020AbRB1A3m>; Tue, 27 Feb 2001 19:29:42 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:3862 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S130017AbRB1A3c>; Tue, 27 Feb 2001 19:29:32 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "David L. Nicol" <david@kasey.umkc.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: another Linux-2.4.2 splat: *** target pattern contains no `%'. Stop. 
In-Reply-To: Your message of "Tue, 27 Feb 2001 15:25:45 MDT."
             <3A9C1B59.2492E5C9@kasey.umkc.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Feb 2001 11:29:25 +1100
Message-ID: <6543.983320165@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2001 15:25:45 -0600, 
"David L. Nicol" <david@kasey.umkc.edu> wrote:
>[david@nicol1 linux]$ make dep
>
>make[3]: Entering directory `/mnt/sdb2/src/linux-2.4.2/drivers'
>make -C acpi fastdep
>make[4]: Entering directory `/mnt/sdb2/src/linux-2.4.2/drivers/acpi'
>Makefile:29: *** target pattern contains no `%'.  Stop.

grep make Documentation/Changes

