Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318263AbSHPJhi>; Fri, 16 Aug 2002 05:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318265AbSHPJhi>; Fri, 16 Aug 2002 05:37:38 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:2252 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318263AbSHPJhg>; Fri, 16 Aug 2002 05:37:36 -0400
Message-ID: <3D5CC8B0.23745AA9@wanadoo.fr>
Date: Fri, 16 Aug 2002 11:41:04 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre2-ac3 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: Arador <diegocg@teleline.es>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac3 does not boot
References: <3D5C14D6.91D215EB@wanadoo.fr> <20020815230854.06632582.diegocg@teleline.es>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arador wrote:
> 
> On Thu, 15 Aug 2002 22:53:42 +0200
> Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr> escribió:
> 
> > Hi !
> >
> > Instead, it does a cold reboot from the BIOS
> 
> I can see that in *every* kernel when i enable the "enhanced memory
> write" in my MSI 5146 motherboard (sis trinity 5571 chipset and a cyrix
> 6x86MX 233+ cpu)
> 
> >
> > ----
> > Regards
> >       Jean-Luc
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

It was my fault, I used an old config file and missed '[*] Have you read
the release notes'

----
Regards
	Jean-Luc
