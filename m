Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263430AbTCNSPA>; Fri, 14 Mar 2003 13:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263431AbTCNSPA>; Fri, 14 Mar 2003 13:15:00 -0500
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70]:45715
	"EHLO mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id <S263430AbTCNSO6>; Fri, 14 Mar 2003 13:14:58 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Mar 2003 10:25:21 -0800
MIME-Version: 1.0
Subject: Re: VESA FBconsole driver?
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
Message-ID: <3E71AE11.29314.4B46B5D@localhost>
References: <3E70A68F.9422.AF1599@localhost>
In-reply-to: <Pine.GSO.4.21.0303141114210.3569-100000@vervain.sonytel.be>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Assumed the BIOS can recover from whatever the application has done to the
> graphics chipset...

If the program just crashed (and did not lock the graphics card), the 
BIOS can nearly always restore the screen properly. I know that from the 
years of doing graphics development under DOS and always using the BIOS 
to restore the screen when I screwed up and crashed my graphics programs 
;-)

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

