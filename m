Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269072AbUJUMAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269072AbUJUMAb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268769AbUJTRVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:21:44 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:901 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S268702AbUJTRNh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:13:37 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Yu, Luming" <luming.yu@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
References: <3ACA40606221794F80A5670F0AF15F8405D3BF5B@pdsmsx403>
	<20041018114109.GC4400@openzaurus.ucw.cz>
	<yw1xekjt4fa8.fsf@mru.ath.cx> <20041020154718.GD26439@elf.ucw.cz>
	<yw1x65554a7d.fsf@mru.ath.cx>
	<1098291205.1429.76.camel@krustophenia.net>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Date: Wed, 20 Oct 2004 19:13:15 +0200
In-Reply-To: <1098291205.1429.76.camel@krustophenia.net> (Lee Revell's
 message of "Wed, 20 Oct 2004 12:53:25 -0400")
Message-ID: <yw1xwtxl2tzo.fsf@mru.ath.cx>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> On Wed, 2004-10-20 at 12:37, Måns Rullgård wrote:
>> I've noticed my laptop makes a slight noise whenever there's heavy
>> network traffic.  Maybe that could be used to control the pitch even
>> without a kernel hack.
>
> Well, in your case the bad capacitors might be in the NIC.  The ethernet
> phones at my last job were so cheaply made that you could hear it ARPing
> through your computer speakers.

I have and old Alphastation where the onboard sound card picks up all
sorts of noise.  If you connect some speakers everything gets it's own
special noise, from cache misses to SCSI traffic.

> I bet you could actually identify the singing capacitor using a
> telephone toner wand.  IMHO this is a bad enough problem to RMA it. 

Not really, it's barely noticeable in a quiet room.

-- 
Måns Rullgård
mru@mru.ath.cx
