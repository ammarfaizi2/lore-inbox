Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287794AbSBHWpA>; Fri, 8 Feb 2002 17:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287804AbSBHWov>; Fri, 8 Feb 2002 17:44:51 -0500
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:51139 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S287794AbSBHWoi>; Fri, 8 Feb 2002 17:44:38 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Alex Riesen <fork0@users.sourceforge.net>
Subject: Re: 2.4.18-pre8-K2: Kernel panic: CPU context corrupt
Date: Fri, 8 Feb 2002 23:44:26 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020208224442Z287794-13996+19396@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, February 08, 2002 at 22:18 +0100, Alex Riesen wrote:
> On Fri, Feb 08, 2002 at 12:36:53AM +0100, Dave Jones wrote:
> > On Fri, Feb 08, 2002 at 12:18:31AM +0100, Alex Riesen wrote:
> >  
> >  > Feb  7 23:45:31 steel kernel: CPU 0: Machine Check Exception:
> >  > 0000000000000004
> >  > Feb  7 23:45:31 steel kernel: Bank 4: b200000000040151
> >  > Feb  7 23:45:31 steel kernel: Kernel panic: CPU context corrupt
> > 
> >  Machine checks are indicative of hardware fault.
> >  Overclocking, inadequate cooling and bad memory are the usual causes.
>
> no overclocking, memtest passed (1 pass, 1 hour), native intel cooler.
> Space radiation, maybe 8)

We run it over night in our lab, to be sure...

Good luck!

-Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
