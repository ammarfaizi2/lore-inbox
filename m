Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289383AbSA1Ulq>; Mon, 28 Jan 2002 15:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289467AbSA1Ulj>; Mon, 28 Jan 2002 15:41:39 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:52792 "EHLO
	tsmtp3.ldap.isp") by vger.kernel.org with ESMTP id <S289398AbSA1Ule>;
	Mon, 28 Jan 2002 15:41:34 -0500
From: "Diego Calleja" <grundig@teleline.es>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: fonts corruption with 3dfx drm module
Date: lun, 28 ene 2002 20:41:56 +0000
In-Reply-To: <Pine.LNX.4.44.0201281612030.18070-100000@netfinity.realnet.co.sz>
X-Mailer: Pyne 0.6.7 (Debian/GNU/Linux)
Content-Type: text/plain
MIME-Version: 1.0
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, <grundig@teleline.es>
Message-Id: <20020128204135Z289398-13997+11239@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 ene 2002, 16:12:34, Zwane Mwaikambo wrote:
> 
> On Mon, 28 Jan 2002, Zwane Mwaikambo wrote:
> 
> > Do you guys have CONFIG_MTRR and/or CONFIG_FB_VESA enabled? Also which 
> > motherboard chipset?
I have CONFIG_MTRR enabled. CONFIG_FB_VESA is disabled.
Moterhboard: MS-5571
Chipset: SIS 5571 Trinity, Video card voodoo 3 3000 PCI
> 
> Forgot to mention, which XFree86 version?

X 4.1.0 (debian woody release)

Diego Calleja.

> 
> Cheers,
> 	Zwane Mwaikambo
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
