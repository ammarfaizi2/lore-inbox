Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbWDNGpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWDNGpp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 02:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWDNGpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 02:45:45 -0400
Received: from ns2.sagem.com ([62.160.59.241]:8602 "EHLO mx2.sagem.com")
	by vger.kernel.org with ESMTP id S965106AbWDNGpo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 02:45:44 -0400
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       Gabor Gombas <gombasg@sztaki.hu>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-ide@vger.kernel.org,
       linux-ide-owner@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: =?ISO-8859-1?Q?R=E9f=2E_=3A_Re=3A_libata-pata_works_on_ICH4-M?=
MIME-Version: 1.0
Message-ID: <OF0E3A280E.A7782B98-ONC1257150.0024EE7D-C1257150.00252647@sagem.com>
From: Matthieu CASTET <matthieu.castet@sagem.com>
Date: Fri, 14 Apr 2006 08:45:36 +0200
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

last time I check, some hdparm flags work fine with libata hard drive but 
not with PATA drive.

Matthieu





Mark Lord <liml@rtr.ca>

Envoyé par : linux-ide-owner@vger.kernel.org
14/04/2006 00:20
Remis le : 14/04/2006 00:21

 
        Pour :  Jan Engelhardt <jengelh@linux01.gwdg.de>
        cc :    Gabor Gombas <gombasg@sztaki.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, 
Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>, 
linux-ide@vger.kernel.org, Linux Kernel Mailing List 
<linux-kernel@vger.kernel.org>, (ccc : Matthieu CASTET/EXT/SAGEM)
        Objet : Re: libata-pata works on ICH4-M



For now, several hdparm flags work fine with libata SCSI drives.

Eg. hdparm -W1, hdparm I, ..

Sometime in the next month or two, I hope to update hdparm to use SGIO
where possible/necessary to enable most of the remaining flags to 
function.

Cheers
-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



