Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316784AbSEUXbM>; Tue, 21 May 2002 19:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316786AbSEUXbL>; Tue, 21 May 2002 19:31:11 -0400
Received: from edcom.no ([194.248.172.30]:11275 "EHLO edcom.no")
	by vger.kernel.org with ESMTP id <S316784AbSEUXai>;
	Tue, 21 May 2002 19:30:38 -0400
From: "Svein E. Seldal" <Svein.Seldal@edcom.no>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Custom kernel version and depmod
Date: Wed, 22 May 2002 01:30:36 +0200
Message-ID: <KKEHJJLHENOALGODMOGLAECICBAA.Svein.Seldal@edcom.no>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <20020521180515.GF1295@kroah.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> From: Greg KH
>
> A bit off-topic, but any reason why you can not just submit your driver
> for inclusion in the main kernel tree?  The USB developers are usually
> quite easy to convince to take new drivers :)

Well I know, but the problem here is that the design is to a development
card. It has not been assigned a VID/PID and neither will it. I dont think
we should clutter the kernel with such drivers, do we?

Anyway, my question was focused on depmod and kernel module version system
and not the driver itself.


Svein

