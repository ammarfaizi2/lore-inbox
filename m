Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276037AbRI1NCR>; Fri, 28 Sep 2001 09:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276038AbRI1NCI>; Fri, 28 Sep 2001 09:02:08 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:16651 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S276037AbRI1NBs>; Fri, 28 Sep 2001 09:01:48 -0400
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: "Bobby Hitt" <bobhitt@bscnet.com>, <linux-kernel@vger.kernel.org>
Subject: RE: 2GB File limitation
Date: Fri, 28 Sep 2001 06:02:11 -0700
Message-ID: <HBEHIIBBKKNOBLMPKCBBAEIIDNAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <013801c147e5$3330bec0$092cdb3f@bobathome>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you know if they ever fixed this same issue in Microsoft Access? :-) Does
Linux support tape drives? :-)

Sure, Linux needs to be able to handle files > 2 GB, but I wonder if backups
over a network to a hard drive are giving you a false sense of "security".
In the "enterprise" world, you have to be *religious* about backups.
Incrementals at least daily, fulls at least weekly, all backups verified and
*off-site secure storage of backup media*. Dang! The soap company wants
their &$^%&$# box back :-).

--
M. Edward (Ed) Borasky, Chief Scientist, Borasky Research
http://www.borasky-research.net  http://www.aracnet.com/~znmeb
mailto:znmeb@borasky-research.net mailto:znmeb@aracnet.com

If there's nothing to astrology, how come so many famous men were born on
holidays?

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Bobby Hitt
> Sent: Thursday, September 27, 2001 11:17 PM
> To: linux-kernel@vger.kernel.org
> Subject: 2GB File limitation
>
>
> Hello,
>
> Is someone working on a way to overcome the 2GB file limitation
> in Linux? I
> currently backup several servers using a dedicated hard drive for the
> backups. Recently I saw one backup die saying the the file size had been
> exceeded. I've never had good luck with tape backups, yes they backup, but
> whenever I really need a file, it can't be retrieved.
>
> TIA,
>
> Bobby
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

