Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135939AbREGGkD>; Mon, 7 May 2001 02:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136017AbREGGjw>; Mon, 7 May 2001 02:39:52 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:1799 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135939AbREGGjn>; Mon, 7 May 2001 02:39:43 -0400
Date: 07 May 2001 08:37:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <80OKvFpXw-B@khms.westfalen.de>
In-Reply-To: <9d4ut6$9b9$1@cesium.transmeta.com>
Subject: Re: [PATCH] for iso8859-13
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <9d4ut6$9b9$1@cesium.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com (H. Peter Anvin)  wrote on 06.05.01 in <9d4ut6$9b9$1@cesium.transmeta.com>:

> Followup to:  <200105062104.XAA24831@green.mif.pg.gda.pl>
> By author:    Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
> In newsgroup: linux.dev.kernel
> >
> > Hi,
> >    The following patch removed unused and broken conversion table from
> > nls_iso8859-13.c.
> >
>
> Wouldn't it make a heck of a lot more sense if we had a preprocessor
> which could produce these kinds of tables from a more sensible input
> format (preferrably one which is already in use somewhere.)

For example from the tables on the Unicode webserver or from the IBM  
charset registry ...


MfG Kai
