Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290215AbSAWXtO>; Wed, 23 Jan 2002 18:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290216AbSAWXtE>; Wed, 23 Jan 2002 18:49:04 -0500
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:6275 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S290215AbSAWXsw>; Wed, 23 Jan 2002 18:48:52 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: timothy.covell@ashavan.org, Daniel Nofftz <nofftz@castor.uni-trier.de>
Subject: Re: [patch] amd athlon cooling on KT133A sensor lockup
Date: Thu, 24 Jan 2002 00:48:45 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ACPI List <acpi@phobos.fachschaften.tu-muenchen.de>
In-Reply-To: <Pine.LNX.4.40.0201232021440.2202-100000@infcip10.uni-trier.de> <20020123202258Z290054-13996+10694@vger.kernel.org> <200201232331.g0NNVTL01437@home.ashavan.org.>
In-Reply-To: <200201232331.g0NNVTL01437@home.ashavan.org.>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020123234900Z290215-13996+10795@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 25. January 2002 00:33, Timothy Covell wrote:
> I tried lvcool on my KT133A/Duron system.  When I ran the
> "sensors" program, it failed to exit and ate up 100% of the
> CPU.  Kill -9 refused to kill it.  I had to reboot to clear the
> problem which doesn't show up if I haven't run lvcool....

Maybe you can run Windows with VCool for a test? --- Yes, yes, I know...;-)

Have you tried the older VCool Linux patch?

I can't do that 'cause I have the AMD 750 (without doku from AMD) as you 
know, already.

-Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
