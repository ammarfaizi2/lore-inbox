Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131400AbRC3NK6>; Fri, 30 Mar 2001 08:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131396AbRC3NKs>; Fri, 30 Mar 2001 08:10:48 -0500
Received: from in-smtp.mmedia.is ([193.4.192.20]:8562 "EHLO in-smtp.mmedia.is")
	by vger.kernel.org with ESMTP id <S131392AbRC3NKl> convert rfc822-to-8bit;
	Fri, 30 Mar 2001 08:10:41 -0500
Message-ID: <B0D96BEDD558D411ACB200105AD7EAE9865922@GEMINI>
From: =?iso-8859-1?Q?Sigurbj=F6rn_Birkir_L=E1russon?= 
	<sibbi@margmidlun.is>
To: "'Roy Sigurd Karlsbakk'" <roy@fast.no>,
   linux-kernel mailinglist <linux-kernel@vger.kernel.org>
Subject: RE: Dell PERC/Adaptec RAID support?
Date: Fri, 30 Mar 2001 13:12:24 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can get patches for 2.4.1 which work fine in 2.4.2 (at least on my 2400)
at:

http://domsch.com/linux/

Along with a decent collection of information about dell poweredge systems
and linux in general.

I recommend 2.4.2, as far as I've seen it run, it seems to fix various
problems I had with the eepro driver in SMP as well.

---
Sigurbjörn B. Lárusson <sibbi@margmidlun.is>/<sibbi@bofh.is>
Kerfisstjóri/System Administrator
Margmiðlun Internet ehf 
ICQ: 76455349

> -----Original Message-----
> From: Roy Sigurd Karlsbakk [mailto:roy@fast.no]
> Sent: 30. mars 2001 12:43
> To: linux-kernel mailinglist
> Subject: Dell PERC/Adaptec RAID support?
> 
> 
> Hi all
> 
> Some months ago, I asked this question, and thought about 
> trying again.
> 
> The PERC/something card, based on the Adaptec (DPT?) chipset, 
> delivered
> by Dell on the Poweredge 2450 series servers among others, is 
> currently
> only supported in specific distributions, and not in the 
> official Linux
> kernels. As I want to run Linux-2.4.x, I can't find a kernel 
> supporting
> the PERC, and this annoys me... Does anyone know when this will be
> merged into the main source tree?
> 
> Please Cc: to me as I'm not on the list
> 
> Regards
> 
> roy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
