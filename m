Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317347AbSILUkN>; Thu, 12 Sep 2002 16:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317349AbSILUkN>; Thu, 12 Sep 2002 16:40:13 -0400
Received: from pD9E23F87.dip.t-dialin.net ([217.226.63.135]:43495 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317347AbSILUkM>; Thu, 12 Sep 2002 16:40:12 -0400
Date: Thu, 12 Sep 2002 14:43:58 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jim Sibley <jlsibley@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Giuliano Pochini <pochini@shiny.it>, <riel@conectiva.com.br>
Subject: RE: Killing/balancing processes when overcommited
In-Reply-To: <1031862920.2902.107.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0209121441060.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12 Sep 2002, Alan Cox wrote:
> On Thu, 2002-09-12 at 20:08, Thunder from the hill wrote:
> > These problems can be solved via ulimit. I was referring to things
> > like rsyncd which was blowing up under certain situations, but runs
> > under a trusted account (say UID=0). In order to condemn it you'd need
> > the setup I've mentioned.
> 
> Ulimit won't help you one iota

Why so pessimistic? You can ban users using ulimit, as you know. (You will 
always remember when you wake up and your memory is ulimited to 1MB.)

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

