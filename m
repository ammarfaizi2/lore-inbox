Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129772AbQK3Fca>; Thu, 30 Nov 2000 00:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129797AbQK3FcV>; Thu, 30 Nov 2000 00:32:21 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:14967 "EHLO
        pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
        id <S129772AbQK3FcD>; Thu, 30 Nov 2000 00:32:03 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Dmitri Matrosov <m3d@mail.utexas.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: submitting ksymoops 
In-Reply-To: Your message of "Wed, 29 Nov 2000 22:49:29 MDT."
             <Pine.LNX.4.21.0011292238140.551-200000@darion.dhs.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 30 Nov 2000 16:01:30 +1100
Message-ID: <6170.975560490@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000 22:49:29 -0600 (CST), 
Dmitri Matrosov <m3d@mail.utexas.edu> wrote:
>i got these modprobing module bttv on linux2.4.0-test11, when loading it
>at startup machine hangs oopsing in endless loop.

grep modutils linux/Documentation/Changes

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
