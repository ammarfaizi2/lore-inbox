Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261402AbTCOFmD>; Sat, 15 Mar 2003 00:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261404AbTCOFmC>; Sat, 15 Mar 2003 00:42:02 -0500
Received: from f18.pav2.hotmail.com ([64.4.37.18]:49416 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261402AbTCOFmC>;
	Sat, 15 Mar 2003 00:42:02 -0500
X-Originating-IP: [211.28.96.71]
From: "dean ." <ioooioiiooi@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: ALSA + mmap or OSS emulation + mmap producing stutering sound
Date: Sat, 15 Mar 2003 05:52:46 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F18MhvqgStMVhEUsebm00002883@hotmail.com>
X-OriginalArrivalTime: 15 Mar 2003 05:52:47.0060 (UTC) FILETIME=[1AE00940:01C2EAB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel versions 2.5.61-64 (Havnt tried 60) produce stuttering sound when 
using alsa and mmap (xmms alsa output plugin) or oss emu and mmap (quake3?) 
produce stuttering sound happening after around the first half second of 
playing. This is with the kernels alsa cs46xx module and a Turtle beach 
Santa Cruz soundcard. Works fine with 2.5.59 though.

_________________________________________________________________


