Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286796AbRLVPGH>; Sat, 22 Dec 2001 10:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286797AbRLVPF6>; Sat, 22 Dec 2001 10:05:58 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:7330 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S286796AbRLVPFt>;
	Sat, 22 Dec 2001 10:05:49 -0500
Date: Sat, 22 Dec 2001 10:05:47 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alvaro Lopes <alvieboy@alvie.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Mount point permissions
In-Reply-To: <1009033045.935.1.camel@dwarf>
Message-ID: <Pine.GSO.4.21.0112221005080.20113-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 22 Dec 2001, Alvaro Lopes wrote:

> Shouldn't mount preserve original mountpoint permissions ?

No, it shouldn't.

