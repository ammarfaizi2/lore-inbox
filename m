Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263017AbREWJIH>; Wed, 23 May 2001 05:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263018AbREWJH5>; Wed, 23 May 2001 05:07:57 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:35375 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S263017AbREWJHu>; Wed, 23 May 2001 05:07:50 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org.com>
cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac14 
In-Reply-To: Your message of "Wed, 23 May 2001 09:17:08 +0200."
             <Pine.LNX.4.05.10105230915100.16280-100000@callisto.of.borg> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 23 May 2001 19:07:38 +1000
Message-ID: <20677.990608858@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2001 09:17:08 +0200 (CEST), 
Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>On Wed, 23 May 2001, Keith Owens wrote:
>> Is drivers/char/ser_a2232fw.ax supposed to be included?  Nothing uses it.
>
>It's the source for the firmware hexdump in ser_a2232fw.h, provided as a
>reference.

What is the point of including it in the kernel source tree without the
code to convert it to ser_a2232fw.h?  Nobody can use ser_a2232fw.ax, it
is just bloat.

