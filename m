Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281023AbRKOUP4>; Thu, 15 Nov 2001 15:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281031AbRKOUPp>; Thu, 15 Nov 2001 15:15:45 -0500
Received: from adglinux1.hns.com ([139.85.108.152]:53911 "EHLO
	adglinux1.hns.com") by vger.kernel.org with ESMTP
	id <S281023AbRKOUP1>; Thu, 15 Nov 2001 15:15:27 -0500
To: linux-kernel@vger.kernel.org
Subject: hardware raid (adaptec 1200A)?
From: nbecker@fred.net
Date: 15 Nov 2001 15:15:19 -0500
Message-ID: <x88g07fn63s.fsf@adglinux1.hns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm setting up a new machine with a pair of IDE drives connected to
adaptec 1200A controller.  I defined a RAID-0 array using the adaptec
bios, but linux doesn't see it as a single drive.  It just sees two
drive, hde and hdg (each at their physical sizes).  Any hints?
