Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318383AbSHPOe4>; Fri, 16 Aug 2002 10:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318389AbSHPOe4>; Fri, 16 Aug 2002 10:34:56 -0400
Received: from host-65-162-110-4.intense3d.com ([65.162.110.4]:42768 "EHLO
	exchusa03.intense3d.com") by vger.kernel.org with ESMTP
	id <S318383AbSHPOez>; Fri, 16 Aug 2002 10:34:55 -0400
Message-ID: <23B25974812ED411B48200D0B774071701248520@exchusa03.intense3d.com>
From: Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>
To: linux-kernel@vger.kernel.org
Subject: Alloc and lock down large amounts of memory
Date: Fri, 16 Aug 2002 09:38:45 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a few questions with regards to alloc'ing and locking down memory.
An example 
would be very useful.  Please CC me on any responses.

1. Is there a mechanism to lock down large amounts of memory (>128M, upto
256M).
    Can 256M be allocated using vmalloc, if so is it swappable?
2. Is it possible for a user process and kernel to access the same shared
memory?
3. Can a shared memory have visibility across processes, i.e. can process A
access 
memory that was allocated by process B?
4. When a process exits will it cause a close to occur on the device?

Thanks,
Bhavana

