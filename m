Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264080AbTDKJo2 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 05:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264086AbTDKJo2 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 05:44:28 -0400
Received: from 213-4-21-244.uc.nombres.ttd.es ([213.4.21.244]:4856 "EHLO
	mail.flconstruccion.com") by vger.kernel.org with ESMTP
	id S264080AbTDKJo1 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 05:44:27 -0400
Message-ID: <3E96AD8A.4040708@inicia.es>
Date: Fri, 11 Apr 2003 13:56:58 +0200
From: =?ISO-8859-1?Q?Pablo_Gim=E9nez_Pizarro?= <pablogipi@inicia.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030212 Debian/1.2.1-9woody1
X-Accept-Language: es-es
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Uresolved Symbol problem in kernel compiled for ATHLON :(
References: <26598.1050053609@kao2.melbourne.sgi.com>
In-Reply-To: <26598.1050053609@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

>On Fri, 11 Apr 2003 13:12:38 +0200, 
>=?ISO-8859-1?Q?Pablo_Gim=E9nez_Pizarro?= <pablogipi@inicia.es> wrote:
>  
>
>>I've compiled a kernel optimized for aTHLON processors and when i reboot 
>>i get the next error nwhen try to load some modules:
>>
>>/lib/modules/2.4.20/kernel/drivers/net/dmfe.o: unresolved symbol _mmx_memcpy
>>    
>>
>
>Broken kernel build system.  You must make mrproper before changing
>processor type or when switching from SMP to UP or vice versa.
>
Thanks i try it this evening !!

>
>
>  
>


-- 
-------
Un saludo

Pablo Giménez Pizarro
-------
La única lucha que se pierde es la que se abandona.
(Mujeres de la Plaza de Mayo)
-------
Albion 3.0 Project: www.albion30.net




