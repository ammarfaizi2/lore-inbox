Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317578AbSGJSCs>; Wed, 10 Jul 2002 14:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317579AbSGJSCr>; Wed, 10 Jul 2002 14:02:47 -0400
Received: from pD952A32F.dip.t-dialin.net ([217.82.163.47]:39553 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317578AbSGJSCq>; Wed, 10 Jul 2002 14:02:46 -0400
Date: Wed, 10 Jul 2002 12:05:03 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "Perches, Joe" <joe.perches@spirentcom.com>
cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, <thunder@ngforever.de>,
       <bunk@fs.tum.de>, <boissiere@adiglobal.com>,
       <linux-kernel@vger.kernel.org>, "'Larry Kessler'" <kessler@us.ibm.com>,
       "'Martin.Bligh@us.ibm.com'" <Martin.Bligh@us.ibm.com>
Subject: RE: [STATUS 2.5]  July 10, 2002
In-Reply-To: <629E717C12A8694A88FAA6BEF9FFCD440540BD@brigadoon.spirentcom.com>
Message-ID: <Pine.LNX.4.44.0207101203200.5067-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 10 Jul 2002, Perches, Joe wrote:
> Do we really need to have the equivalent of:
> 	printk(tr("Context string %s: %d"),tr("some string"),value);
> translate/lookups?  Why?  If so, is this facility supposed to be
> run-time or compile-time?

Ah, I see. Somewhen I have some piece of english text that I want to send 
to some japanese people, and when I do C-X in my pine, it gets translated 
to japanese automatically by the kernel network layer...

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

