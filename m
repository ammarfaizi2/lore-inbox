Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312524AbSCYTzA>; Mon, 25 Mar 2002 14:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312534AbSCYTyv>; Mon, 25 Mar 2002 14:54:51 -0500
Received: from jagor.srce.hr ([161.53.2.130]:11774 "EHLO jagor.srce.hr")
	by vger.kernel.org with ESMTP id <S312524AbSCYTyi>;
	Mon, 25 Mar 2002 14:54:38 -0500
Message-Id: <200203251954.UAA03613@jagor.srce.hr>
Content-Type: text/plain; charset=US-ASCII
From: Danijel Schiavuzzi <dschiavu@public.srce.hr>
Organization: Dead Poets Society
To: Andre Pang <ozone@algorithm.com.au>
Subject: Re: Screen corruption in 2.4.18
Date: Mon, 25 Mar 2002 20:52:45 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr> <200203241507.g2OF7WN26069@ls401.hinet.hr> <1017021338.345762.13479.nullmailer@bozar.algorithm.com.au>
X-UIN: 39223454
X-Operating-System: GNU/Linux 2.4.17
X-Troll: no
X-URL: <http://danijels.cjb.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Cc: linux-kernel@vger.kernel.org, Steven Walter <srwalter@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 March 2002 02:55, you wrote:
> On Sun, Mar 24, 2002 at 04:07:31PM +0100, Danijel Schiavuzzi wrote:
> > > same screen corruption.  Clearing only bit 7 of register 55 fixes
> >
> > Well, we're not the only ones with this problem. BTW, which motherboard
> > do you have? Maybe it's a mainboard failure (mine is a MSI MS-6340M V1).
> > I know one more Linux user with this problem on the same M/B.
>
> I have an Asus A7VC.  They're the motherboards that come with the
> cute little Asus Terminator K7s[1]; I have no idea if you can
> actually get this motherboard if you don't buy that kit.  So it's
> not a motherboard-specific problem.

OK.

> Relevant output from lspci for the A7VC:
>
>     00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
> (rev 81) 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365
> [KT133/KM133 AGP] 01:00.0 VGA compatible controller: S3 Inc. ProSavage
> KM133 (rev 03)
>
>     00:00.0 Class 0600: 1106:0305 (rev 81)
>     00:01.0 Class 0604: 1106:8305
>     01:00.0 Class 0300: 5333:8a26 (rev 03)

Yes, exactly the same as my...

Danijel

