Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131587AbRCXLHI>; Sat, 24 Mar 2001 06:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131644AbRCXLG6>; Sat, 24 Mar 2001 06:06:58 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:13841 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S131587AbRCXLGy>; Sat, 24 Mar 2001 06:06:54 -0500
Message-ID: <3ABC7F9C.74AA7AB2@Hell.WH8.TU-Dresden.De>
Date: Sat, 24 Mar 2001 12:06:04 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac24 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2-ac24
In-Reply-To: <E14gcs7-0005rb-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> 2.4.2-ac24
> 2.4.2-ac23
> o       Back out problem via bridge change              (me)

That fixed the bttv problems I had. I've noticed that there are
four VIA vt8363 PCI fixups by now. Are these experimental to see if
some people's problems go away or have VIA confirmed that there
is a problem? 

Regards,
-Udo.
