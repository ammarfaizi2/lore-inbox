Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318542AbSIKKZr>; Wed, 11 Sep 2002 06:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318661AbSIKKZr>; Wed, 11 Sep 2002 06:25:47 -0400
Received: from ns1.mscsoftware.com ([192.207.69.10]:1164 "EHLO
	draco.macsch.com") by vger.kernel.org with ESMTP id <S318542AbSIKKZZ> convert rfc822-to-8bit;
	Wed, 11 Sep 2002 06:25:25 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Knoblauch <martin.knoblauch@mscsoftware.com>
Reply-To: martin.knoblauch@mscsoftware.com
Organization: MSC.Software GmbH
To: axboe@suse.de
Subject: Re: Oops + Aiee when mounting CDROM via ide-scsi under 2.4.20-pre5-ac4
Date: Wed, 11 Sep 2002 12:28:15 +0200
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209111228.15954.martin.knoblauch@mscsoftware.com>
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.2; AVE: 6.15.0.1; VDF: 6.15.0.7
	 at mailmuc has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ok try this patch, against 2.4.20-pre5-ac4 (well not a clean one, but 
> I think it should apply). 
> 
> 
> alan, this should probably go into ac5 provided that Martin tests it
> as ok. 
Jens, Alan.

 BBW (Boots, Builds, Works :-). Thanks you very much. After the patch 
mounting CD's through ide-scsi works like a charm.

 So, from my point of view it should go into pre5-ac5 or pre6-ac1.

Martin
-- 
Martin Knoblauch
Senior System Architect
MSC.software GmbH
Am Moosfeld 13
D-81829 Muenchen, Germany

e-mail: martin.knoblauch@mscsoftware.com
http://www.mscsoftware.com
Phone/Fax: +49-89-431987-189 / -7189
Mobile: +49-174-3069245

