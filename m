Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261988AbRFDAGP>; Sun, 3 Jun 2001 20:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263816AbRFCXdV>; Sun, 3 Jun 2001 19:33:21 -0400
Received: from mx01-a.netapp.com ([198.95.226.53]:23748 "EHLO
	mx01-a.netapp.com") by vger.kernel.org with ESMTP
	id <S263797AbRFCXYA>; Sun, 3 Jun 2001 19:24:00 -0400
Date: Sun, 3 Jun 2001 16:23:48 -0700 (PDT)
From: Kip Macy <kmacy@netapp.com>
To: linux-kernel@vger.kernel.org
Subject: Looking for device to write device driver for
Message-ID: <Pine.GSO.4.10.10106031613160.14668-100000@orbit-fe.eng.netapp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may well be a question whose appropriate response is RTFM. 
However, I did look first. 

I am taking a class on writing device drivers for Linux. I am currently
looking for a device to write a driver for. I first tried to get the
engineering specification for my soundcard, but after much frustration I
gave up on dealing with the manufacturer. I then tried to get the
interface information from 3com on their new 3cr990 card to add IPsec
offload support to the linux driver. They responded by telling me that due
to IP-heavy nature of the product that they would not be releasing the
interface. It was later explained to me (in different terms) that most
cards on the market are fundamentally commodity items and as such the only
way that manufacturers can ensure their margins is by obscuring the
interface so that other manufacturers don't use the same interface and
undercut them.

This leads to my question: Is there some central resource for listing
unsupported cards that people have expressed an interest in seeing
supported. The closest I could find was Cosource, but that is fairly
limited.

		-Kip

