Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274298AbRJNFL0>; Sun, 14 Oct 2001 01:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274305AbRJNFLQ>; Sun, 14 Oct 2001 01:11:16 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:20706 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274298AbRJNFLG>;
	Sun, 14 Oct 2001 01:11:06 -0400
Date: Sun, 14 Oct 2001 01:11:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Brian Landsberger <brian@landsberger.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount hanging 2.4.12
In-Reply-To: <1003031732.1261.1.camel@fux0r.landsberger.com>
Message-ID: <Pine.GSO.4.21.0110140108420.3903-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 13 Oct 2001, Brian Landsberger wrote:

> I've noticed this happening once in a while on my CF loader (Sandisk
> Imagemate) on and off again ever since 2.4.9. FAT filesystem,
> usb-storage.

OK, folks,  How about strace of the stuff that happen there?  Preferably -
timestamped, to match with relevant part of syslog...

