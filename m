Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290069AbSAKTBf>; Fri, 11 Jan 2002 14:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290070AbSAKTBQ>; Fri, 11 Jan 2002 14:01:16 -0500
Received: from magic.adaptec.com ([208.236.45.80]:50850 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S290069AbSAKTA6>; Fri, 11 Jan 2002 14:00:58 -0500
Message-ID: <F4C5F64C4EBBD51198AD009027D61DB31C8320@otcexc01.otc.adaptec.com>
From: "Bonds, Deanna" <Deanna_Bonds@adaptec.com>
To: "'Steffen Persvold'" <sp@scali.no>, lkml <linux-kernel@vger.kernel.org>
Subject: RE: Adaptec 200{0,5}S zero channel raid adapters
Date: Fri, 11 Jan 2002 14:00:55 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

They are supported with the Adaptec I2O RAID driver - dpt_i2o.  

Deanna

> -----Original Message-----
> From: Steffen Persvold [mailto:sp@scali.no]
> Sent: Friday, January 11, 2002 1:40 PM
> To: lkml
> Subject: Adaptec 200{0,5}S zero channel raid adapters
> 
> 
> Hi all,
> 
> Any chance the Adaptec 2000S and 2005S ZCR (Zero Channel 
> Raid) controllers will be supported on
> Linux soon ? I see that they are already supported by FreeBSD 
> 4.4-RELEASE. There are already a few
> great motherboards that have slots for it (SuperMicro, Tyan, Asus).
> 
> Regards,
> -- 
>   Steffen Persvold   | Scalable Linux Systems |   Try out the 
> world's best   
>  mailto:sp@scali.no  |  http://www.scali.com  | performing 
> MPI implementation:
> Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 
> 1.12.2 -         
> Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >300MBytes/s 
> and <4uS latency
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
