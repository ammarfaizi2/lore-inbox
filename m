Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSGEPX7>; Fri, 5 Jul 2002 11:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317474AbSGEPX6>; Fri, 5 Jul 2002 11:23:58 -0400
Received: from mail.spylog.com ([194.67.35.220]:12938 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S317473AbSGEPX5>;
	Fri, 5 Jul 2002 11:23:57 -0400
Date: Fri, 5 Jul 2002 19:26:26 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa4 & Intel EtherExpress driver "e100".
Message-ID: <20020705152626.GA2630@an.local>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20020705100830.GX1227@dualathlon.random> <Pine.LNX.4.44.0207051601040.29523-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207051601040.29523-100000@netfinity.realnet.co.sz>
User-Agent: Mutt/1.3.28i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Zwane Mwaikambo,

> > > M/B Intel STL2:
> > > 	- ServerWorks ServerSet III LE chipset).
> > >   - Integrated on-board Intel EtherExpress PRO100+ 10/100mbit PCI controller
> > >     (Intel 82559)
> 
> Do we have the same hardware?

Yes.

> OEM ID: INTEL    Product ID: STL2         APIC at: 0xFEE00000
> 
> 00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
> 00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
> 00:02.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC  [Mach64 GT IIC] (rev 7a)
> 00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
> 00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
> 00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
> 01:04.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
> 01:04.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
> 01:0b.0 RAID bus controller: IBM Netfinity ServeRAID controller
> 
> Linux version 2.4.19-rc1-aa1-zm1 (zwane@lserver.waterford.sz) (gcc version 
> 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #6 SMP Mon Jul 1 14:07:40 SAST 
> 2002


Linux 2.4.19-rc1aa1 - work OK.


> > Can you confirm rc1aa1 works again? in next -aa I'll upgrade again to
> > the 2.0.30-k release using another patch to see if it still malfunction
> > for you.
> 
> I've got that machine on a couple of days uptime serving 4G+ a day via 
> that network card. All good so far.
> 
> Cheers,
> 	Zwane Mwaikambo
> -- 
> http://function.linuxpower.ca
> 		
> 

-- 
bye.
Andrey Nekrasov, SpyLOG.
