Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318348AbSIBSVR>; Mon, 2 Sep 2002 14:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318349AbSIBSVQ>; Mon, 2 Sep 2002 14:21:16 -0400
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:62189 "HELO
	dardhal.mired.net") by vger.kernel.org with SMTP id <S318348AbSIBSVQ>;
	Mon, 2 Sep 2002 14:21:16 -0400
Date: Mon, 2 Sep 2002 20:25:40 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: recompiling kernel for a Soltek 75drv4
Message-ID: <20020902182540.GA2538@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3D731C59.CA5796CF@tid.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D731C59.CA5796CF@tid.es>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 02 September 2002, at 10:07:53 +0200,
Miguel González Castaños wrote:

>  - The system is not shutdown completely, I got a Power down message and
> I got to power off the PC.
> 
You must have either APM or ACPI support compiled into the kernel to get
your motherboard switch the power off. I have a Soltek SL-75DRV2 and it
works fine with respect to power down.

Hope it helps.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Woody (Linux 2.4.19-pre6aa1)
