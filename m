Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280114AbRLLOH6>; Wed, 12 Dec 2001 09:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280190AbRLLOHs>; Wed, 12 Dec 2001 09:07:48 -0500
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:40850 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S280114AbRLLOHe>; Wed, 12 Dec 2001 09:07:34 -0500
Date: Wed, 12 Dec 2001 15:07:27 +0100 (CET)
From: Frank Cornelis <fcorneli@elis.rug.ac.be>
To: <linux-kernel@vger.kernel.org>
Subject: extended ptrace patch
Message-ID: <Pine.LNX.4.33.0112121459370.7820-100000@trappist.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As part of my thesis I've written an extended ptrace i386 syscall patch.
This patch makes it possible to trace the memory writes made by 
system calls in a very easy way. If anyone else is looking for such a 
thing, I've put it online.
Since it's my first 'big' kernel patch feedback would be very appriciated.
The address,
	http://www.elis.rug.ac.be/~fcorneli/

Frank.

