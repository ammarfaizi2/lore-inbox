Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289592AbSAJTIj>; Thu, 10 Jan 2002 14:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289609AbSAJTI3>; Thu, 10 Jan 2002 14:08:29 -0500
Received: from sweetums.bluetronic.net ([66.57.88.6]:63433 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S289592AbSAJTIM>; Thu, 10 Jan 2002 14:08:12 -0500
Date: Thu, 10 Jan 2002 14:08:09 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Chris Ball <chris@void.printf.net>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Bigggg Maxtor drives (fwd)
In-Reply-To: <20020110040308.A28692@void.printf.net>
Message-ID: <Pine.GSO.4.33.0201101404530.28783-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Chris Ball wrote:
>> (would it not get the size of the drive from the bios?)
>
>No, the kernel tends not to rely on the BIOS for geometry.  Which is
>usually very wise.

Except for rare cases involving LILO.  It needs to know what the BIOS thinks
the geometry is.  In the case of my laptop (Compaq LTE 5400 -- I know, buy
something less that a decade old), I have to guess since linux doesn't keep
anything the BIOS provides.

--Ricky


