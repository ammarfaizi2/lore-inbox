Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262781AbSITPee>; Fri, 20 Sep 2002 11:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262783AbSITPed>; Fri, 20 Sep 2002 11:34:33 -0400
Received: from t-raenon.nmd.msu.ru ([193.232.127.69]:6353 "HELO
	t-raenon.nmd.msu.ru") by vger.kernel.org with SMTP
	id <S262781AbSITPec>; Fri, 20 Sep 2002 11:34:32 -0400
Date: Fri, 20 Sep 2002 19:39:33 +0400
From: Alexander Lyamin <flx@msu.ru>
To: Alexander Lyamin <flx@msu.ru>, Mark Hounschell <markh@compro.net>,
       Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: [P4DC6+]  Booting problems with dual p4 on i860 chipset with 2.4 and 2.5
Message-ID: <20020920193933.C14066@t-raenon.nmd.msu.ru>
Reply-To: flx@msu.ru
Mail-Followup-To: Alexander Lyamin <flx@msu.ru>,
	Mark Hounschell <markh@compro.net>, Oleg Drokin <green@namesys.com>,
	linux-kernel@vger.kernel.org
References: <20020920190537.A11244@namesys.com> <3D8B3BDE.11C7E177@compro.net> <20020920193138.B14066@t-raenon.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020920193138.B14066@t-raenon.nmd.msu.ru>
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.15-pre9
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Sep 20, 2002 at 07:31:38PM +0400, Alexander Lyamin wrote:
> Fri, Sep 20, 2002 at 11:16:46AM -0400, Mark Hounschell wrote:
> > Oleg Drokin wrote:
> > > 
> > > Hello!
> > > 
> > >    We have a problem with newly acquired dual p4 xeon (2.2Ghz, heperthreading
> > >    blah blah) box built on i860 chipset (SuperMicro P4DC6+ motherboard).
> > >    Thank you.
> > > 
> > 
> > I've got 6 of them here running SuSE 8.0. Hyperthreading was disabled in the
> > bios when Suse-8.0 was
> > installed and 3 of the 6 had the clock speed set at it's lowest setting when
> > they arrived but other than that there were no problems. HT was enabled after
> > the install of SuSE-8.0 and no problems there either. ?????
> 
> what is your bios version Mark ?

Ok, with bios updated to 1.2b (initially we had 1.2a) AND
after toggling  MPS1.4>MPS1.1>MPS1.4  and Hyperthreading OFF and then back
ON it finally boots.

P.S.
new hardware is black box full of cheap tricks most of time :)
-- 
"Cache remedies via multi-variable logic shorts will leave you crying."(cl)
Lex Lyamin
