Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129945AbRBENPx>; Mon, 5 Feb 2001 08:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132882AbRBENPn>; Mon, 5 Feb 2001 08:15:43 -0500
Received: from cnxt09045.conexant.com ([198.62.9.45]:30225 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129945AbRBENPe>; Mon, 5 Feb 2001 08:15:34 -0500
Date: Mon, 5 Feb 2001 14:15:19 +0100 (CET)
From: <rui.sousa@conexant.com>
To: Pat Verner <pat@isis.co.za>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.[01] and BogoMips
In-Reply-To: <4.3.2.7.0.20010205133359.00aac3f0@192.168.0.18>
Message-ID: <Pine.LNX.4.30.0102051414030.4754-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2001, Pat Verner wrote:

> I have Linux running on several older Pentium machines - Pentium -166 MHz
> and Pentium - 120 Mhz.
>
> Under kernel 2.2.13+ these machines report a BogoMips of 66 or 47
> respectively;  suddenly under kernel 2.4.[01] the speed is suddenly
> reported as 332 and 238 respectively.
>
> Has there been a change in the definition of "BogoMips"?

No. It is still as bogus as before.

Rui Sousa

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
