Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269187AbRGaGVY>; Tue, 31 Jul 2001 02:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269193AbRGaGVP>; Tue, 31 Jul 2001 02:21:15 -0400
Received: from zok.sgi.com ([204.94.215.101]:25003 "EHLO zok.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S269187AbRGaGVG>;
	Tue, 31 Jul 2001 02:21:06 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.8-pre3 drivers/usb/storage/scsiglue.c 
In-Reply-To: Your message of "Mon, 30 Jul 2001 22:50:51 MST."
             <20010730225051.B14078@one-eyed-alien.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Jul 2001 16:21:04 +1000
Message-ID: <2852.996560464@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001 22:50:51 -0700, 
Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:
>Or does the const keywork refer only to the struct, not to the pointer?  If
>that's the case, then the keyword should be there....

const refers to the structure, not the pointer to the structure.

