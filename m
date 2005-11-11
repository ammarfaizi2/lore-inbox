Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVKKTus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVKKTus (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVKKTus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:50:48 -0500
Received: from gold.veritas.com ([143.127.12.110]:33917 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751121AbVKKTur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:50:47 -0500
Date: Fri, 11 Nov 2005 19:49:33 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: =?ISO-8859-1?Q?Michael_=C5lenius?= <michael.alenius@gmail.com>
cc: Fawad Lateef <fawadlateef@gmail.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Please report this to linux-kernel@vger.kernel.org
In-Reply-To: <6a42705d0511111042p1e92b0adsf9aa91784b443529@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0511111943270.2814@goblin.wat.veritas.com>
References: <6a42705d0511111042p1e92b0adsf9aa91784b443529@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1452599127-1131738573=:2814"
X-OriginalArrivalTime: 11 Nov 2005 19:50:47.0116 (UTC) FILETIME=[35A4B8C0:01C5E6F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1452599127-1131738573=:2814
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 11 Nov 2005, Michael =C3=85lenius wrote:

> Upgraded  to fedora FC4 Development.repo.(kernel-2.6.14-1.1660_FC5)
> Newbie.So don't know which part to send,or if all of dmesg.
> Please inform me of what you need?If anything.

Thank you, Michael.  Yes, we've had a few other reports of this,
and we're currently considering what patch to make for it.
I'll come back to you if we need more info.

You did just the right thing reporting this as you have done,
please ignore Fawad's well-intentioned response ;)

Hugh

> SELinux: initialized (dev hdc, type iso9660), uses genfs_contexts
> application mixer_applet2 uses obsolete OSS audio interface
> eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
> eth0: no IPv6 routers present
> ISO 9660 Extensions: Microsoft Joliet Level 3
> ISOFS: changing to secondary root
> SELinux: initialized (dev hdc, type iso9660), uses genfs_contexts
> program ddcprobe is using MAP_PRIVATE, PROT_WRITE mmap of VM_RESERVED
> memory, wh ich is deprecated. Please report this to
> linux-kernel@vger.kernel.org
--8323584-1452599127-1131738573=:2814--
