Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291345AbSBSMZU>; Tue, 19 Feb 2002 07:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291359AbSBSMZK>; Tue, 19 Feb 2002 07:25:10 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:47887 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291345AbSBSMZC>; Tue, 19 Feb 2002 07:25:02 -0500
Date: Tue, 19 Feb 2002 13:25:00 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Christy <christy@attglobal.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: via686/AD1886/Soundmax drivers
Message-ID: <20020219132500.A18055@suse.cz>
In-Reply-To: <20020219090303.4d5ef5f3.christy@attglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020219090303.4d5ef5f3.christy@attglobal.net>; from christy@attglobal.net on Tue, Feb 19, 2002 at 09:03:03AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2002 at 09:03:03AM +0000, Peter Christy wrote:

> I am not a serious programmer (I peaked with 6502s and haven't done any
> machine level stuff since!), but following hints in the earlier threads I
> added the following lines to the kernel source ac97_codec.c file:
> 
> 	{0x41445361, "Analog Devices AD1886",	&default_ops},
> 	{0x41445461, "Analog Devices AD1886",	&default_ops},
> 
> I added both lines as I had conflicting information as to the 0x4144
> numbers.

It's simple, they're "ADS" ...

-- 
Vojtech Pavlik
SuSE Labs
