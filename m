Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287258AbSACNKb>; Thu, 3 Jan 2002 08:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287269AbSACNKV>; Thu, 3 Jan 2002 08:10:21 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:56328 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S287258AbSACNKO>; Thu, 3 Jan 2002 08:10:14 -0500
Message-Id: <200201031310.g03DA8rB021258@pincoya.inf.utfsm.cl>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems? 
In-Reply-To: Message from "Eric S. Raymond" <esr@thyrsus.com> 
   of "Wed, 02 Jan 2002 17:34:19 CDT." <20020102173419.A21165@thyrsus.com> 
Date: Thu, 03 Jan 2002 10:10:07 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> said:
[...]

> What?  Perhaps we're talking at cross-prorposes here.  What I'm proposing
> is that /proc/dmi should be a world-readable /proc file with the property
> that 
> 	cat /proc/dmi
> 
> gives you a DMI report.  No root privileges or SUID programs needed.
> Surely that would be an improvement on having to run Arjan's dmidecode as
> root or requiring it to be SUID.

You seem to assume that in-kernel code is automatically safe...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
