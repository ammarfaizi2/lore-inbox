Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310470AbSCXRNr>; Sun, 24 Mar 2002 12:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310560AbSCXRNh>; Sun, 24 Mar 2002 12:13:37 -0500
Received: from jagor.srce.hr ([161.53.2.130]:22716 "EHLO jagor.srce.hr")
	by vger.kernel.org with ESMTP id <S310470AbSCXRN1>;
	Sun, 24 Mar 2002 12:13:27 -0500
Message-Id: <200203241713.SAA20705@jagor.srce.hr>
Content-Type: text/plain; charset=US-ASCII
From: Danijel Schiavuzzi <dschiavu@public.srce.hr>
Organization: Dead Poets Society
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Screen corruption in 2.4.18
Date: Sun, 24 Mar 2002 18:13:13 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E16pBDX-0006fl-00@the-village.bc.nu>
Cc: linux-kernel@vger.kernel.org, srwalter@yahoo.com (Steven Walter),
        ozone@algorithm.com.au (Andre Pang),
        Tom Eastep <teastep@shorewall.net>, Tom Brehm <BrehmTomB@aol.com>
X-UIN: 39223454
X-Operating-System: GNU/Linux 2.4.17
X-Troll: no
X-URL: <http://danijels.cjb.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 March 2002 17:51, you wrote:
> > > same screen corruption.  Clearing only bit 7 of register 55 fixes
> >
> > Well, we're not the only ones with this problem. BTW, which motherboard
> > do you have? Maybe it's a mainboard failure (mine is a MSI MS-6340M V1).
> > I know one more Linux user with this problem on the same M/B.
>
> Does everyone who sees this problem have the 8363/5 combination with the
> onboard Pro-Savage
>
> Alan

Hi,

AFAIK, these people are having these problems and using VT8365 (KM133) 
(ProSavage graphics is integrated in this northbridge):

me <dschiavu@jagor.srce.hr>
Tom Brehm <BrehmTomB@aol.com>
Andre Pang <ozone@algorithm.com.au>
Steven Walter <srwalter@yahoo.com>
Tom Eastep <teastep@shorewall.net>

Regards,

Danijel
