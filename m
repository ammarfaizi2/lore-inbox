Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTL0QSD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 11:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbTL0QSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 11:18:03 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:10657 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264496AbTL0QSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 11:18:00 -0500
Date: Sat, 27 Dec 2003 08:17:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: azarah@nosferatu.za.org
cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 sound output - wierd effects
Message-ID: <2090000.1072541872@[10.10.2.4]>
In-Reply-To: <1072523532.12308.55.camel@nosferatu.lan>
References: <1080000.1072475704@[10.10.2.4]> <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]> <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]> <1072482611.21020.71.camel@nosferatu.lan>  <2060000.1072483186@[10.10.2.4]> <1072486379.12308.33.camel@nosferatu.lan>  <3820000.1072499679@[10.10.2.4]> <1072523532.12308.55.camel@nosferatu.lan>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> > If you right click on xmms, and then select options->preferences, on the
>> >> > first page to the bottom there should be output plugin.  If you cannot
>> >> > select alsa, see if there is a xmms-alsa or libxmms-alsa plugin.  Sorry,
>> >> > I do not know Debian that well.
>> >> 
>> >> Thanks, it was on OSS - there's no ALSA selection, nor can I find one.
>> >> There's probably one in unstable somewhere, but ... see below.
>> > 
>> > Btw, compile xmms yourself - should have alsa then =)  Not sure if
>> > it will if you build with apt-get from source, or when they started
>> > to ship the alsa module with xmms source - think it was not so long
>> > ago.  Does with 1.2.8 though:
>> 
>> Oh, I understand I could work around the problem in userspace, but that's 
>> not the point - something broke in the kernel, presumably OSS emulation.
>> test2 works, test3 doesn't. 
>> 
> 
> It might be that there always was a problem in userspace ... Like I said
> in another mail - its working here now.  Also, _did_ you try something
> else than xmms ... it may be an xmms issue, and not a alsa one ... ?

Nope. But I find it hard to believe, given that it's so consistent on 
switching kernels, and others have had the same problem.

M.

