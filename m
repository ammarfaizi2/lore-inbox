Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266141AbRGDTMC>; Wed, 4 Jul 2001 15:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266142AbRGDTLv>; Wed, 4 Jul 2001 15:11:51 -0400
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:9089 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S266141AbRGDTLn>;
	Wed, 4 Jul 2001 15:11:43 -0400
Message-ID: <3B436A62.8394C783@mirai.cx>
Date: Wed, 04 Jul 2001 12:11:30 -0700
From: J Sloan <jjs@mirai.cx>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: >128 MB RAM stability problems (again)
In-Reply-To: <994279551.1116.0.camel@tux>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald Bultje wrote:

> I'm kind of astounded now, WHY can't linux-2.4.x run on ANY machine in
> my house with more than 128 MB RAM?!? Can someone please point out to me
> that he's actually running kernel-2.4.x on a machine with more than 128
> MB RAM and that he's NOT having severe stability problems?

I don't have the answer for your situation, but in
answer to one of your questions I can happily
enumerate the following boxes I installed, all of
which are running 2.4.x kernels on Red Hat 7.1
with excellent stability and performance:

"Name Brand" boxes:
(3) Dell 2450s, Dual P3-1000, 512 MB RAM
(2) HP Netservers, P3-700, 512 MB RAM
Compaq 6500, Quad PPro 200, 1 GB RAM

Self built clone boxes:
AMD K6/2 450, 256 MB RAM, low end ASUS mb
P3-933, 512 MB RAM, Intel i810 motherboard
P3-866, 512 MB RAM, Aopen motherboard
and more -

These boxes either have an uptime dating from
the initial 7.1 install (60+ days), or from the last
kernel update -

cu

jjs




