Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262323AbSJVJ2E>; Tue, 22 Oct 2002 05:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262354AbSJVJ2E>; Tue, 22 Oct 2002 05:28:04 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:16101 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S262323AbSJVJ2D>;
	Tue, 22 Oct 2002 05:28:03 -0400
Date: Tue, 22 Oct 2002 11:34:10 +0200
From: bert hubert <ahu@ds9a.nl>
To: Take Vos <Take.Vos@binary-magic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: PCMCIA cardmgr kill hangs kernel
Message-ID: <20021022093410.GA2392@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Take Vos <Take.Vos@binary-magic.com>, linux-kernel@vger.kernel.org
References: <200210221046.46700.Take.Vos@binary-magic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210221046.46700.Take.Vos@binary-magic.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 11:01:31AM +0200, Take Vos wrote:

> kernel:	linux-2.5.43
> cardmgr:	3.2.1
> hardware:DELL Inspiron 8100
> config:	CONFIG_PCMCIA
> 		CONFIG_CARDUBS
> 		CONFIG_BLK_DEV_IDECS
> 
> killing the cardmgr hangs the kernel,

How hard? Does numlock still work? Can you tell if the CPU is busy
afterwards (ie, your laptop remains hot).

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
