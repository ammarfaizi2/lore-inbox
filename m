Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSHYLCi>; Sun, 25 Aug 2002 07:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSHYLCi>; Sun, 25 Aug 2002 07:02:38 -0400
Received: from pD9E236A6.dip.t-dialin.net ([217.226.54.166]:49064 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317232AbSHYLCh>; Sun, 25 Aug 2002 07:02:37 -0400
Date: Sun, 25 Aug 2002 05:06:34 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Toon van der Pas <toon@vanvergehaald.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] make localconfig
In-Reply-To: <Pine.LNX.4.44.0208251256130.28574-100000@linux-box.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0208250503540.3234-100000@hawkeye.luckynet.adm>
X-Location: Potsdam-Babelsberg; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 25 Aug 2002, Zwane Mwaikambo wrote:
> For this kind of thing, code talks. Otherwise no one will take heed.

I can't currently supply code, but the thing I'm doing is:

 - parse the dmesg for the vital stuff (the things that were loaded up to 
   the moment may be used very often...)
 - Find out what code it's belonging to
 - Configure that code in
 - The rest is CONFIG_MODULE

So what?

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

