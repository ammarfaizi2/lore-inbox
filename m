Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSHFT4G>; Tue, 6 Aug 2002 15:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSHFT4G>; Tue, 6 Aug 2002 15:56:06 -0400
Received: from erasmus.off.net ([64.39.30.25]:49419 "EHLO mail.off.net")
	by vger.kernel.org with ESMTP id <S315439AbSHFT4G>;
	Tue, 6 Aug 2002 15:56:06 -0400
Date: Tue, 6 Aug 2002 15:59:43 -0400
From: Zach Brown <zab@zabbo.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Voluspa <voluspa@bigfoot.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 MAESTRO sound /dev/dsp3 broken (luxury problem)
Message-ID: <20020806155943.C15208@erasmus.off.net>
References: <20020806004059.43db99fb.voluspa@bigfoot.com> <1028593223.18478.129.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1028593223.18478.129.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Aug 06, 2002 at 01:20:23AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you try and find out exactly which kernel it broke at. The only
> maestro change Im aware of was in rc1-ac7 and wouldn't have that affect
> in any way I can imagine..

I remember reports from the depths of time that dsp3 didn't work.  I
wonder if there is some generation of chip that has a faulty set of high
apus.

-- 
 zach
