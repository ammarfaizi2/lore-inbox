Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbTJYHRu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 03:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbTJYHRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 03:17:50 -0400
Received: from as102.hinet.hr ([195.29.150.42]:23300 "EHLO as102.htnet.hr")
	by vger.kernel.org with ESMTP id S262531AbTJYHRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 03:17:49 -0400
From: Mark B <mark@lemna.hr>
To: kris <kris.buggenhout@skynet.be>
Subject: Re: problems with Seagate 120 GB drives when mutlwrite = 16
Date: Sat, 25 Oct 2003 09:23:27 +0200
User-Agent: KMail/1.5
References: <1066578892.3091.11.camel@borg-cube.lan> <200310191908.14369.bzolnier@elka.pw.edu.pl> <1067002420.3015.7.camel@borg-cube.lan>
In-Reply-To: <1067002420.3015.7.camel@borg-cube.lan>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310250923.27866.mark@lemna.hr>
X-Trace: as102.htnet.hr 1067066347 22771 195.29.150.2 (Sat, 25 Oct 2003 09:19:07 +0200)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 24 October 2003 15:33, kris wrote:
> The 60GB disk (with the OS) is working fine on my nforce ide controller.
> but the 120GB disks are not... I verified, it is not a cabling issue...
> used different cables, different lengths, at the moment they are
> connected with shielded rounded cables.
>
> Is there a fix for this ( not the workaround ... disabling dma) or are
> these 120Gb disks just plain bad choice.... ;(

No, the same is on smaller Seagate disks, I have alot of 40GB Seagates running 
on 2.4.16/18 and they put the message on every boot, I can't remember 100% 
for 2.4.16, but 18 definetly.


-- 
Mark Burazin 
mark@lemna.hr
---<>---<>---<>---<>---<>---<>---<>---<>---<>
Lemna d.o.o.
http://www.lemna.biz - info@lemna.hr
<>---<>---<>---<>---<>---<>---<>---<>---<>---


