Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272672AbRIMCeN>; Wed, 12 Sep 2001 22:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272710AbRIMCeD>; Wed, 12 Sep 2001 22:34:03 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:62220 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S272672AbRIMCdw>;
	Wed, 12 Sep 2001 22:33:52 -0400
Envelope-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Message-Id: <a05100305b7c5ca00303a@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.33.0109111814200.26348-100000@Expansa.sns.it>
In-Reply-To: <Pine.LNX.4.33.0109111814200.26348-100000@Expansa.sns.it>
Date: Thu, 13 Sep 2001 03:30:01 +0100
To: Luigi Genoni <kernel@expansa.sns.it>, Nicholas Knight <tegeran@home.com>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [GOLDMINE!!!] Athlon optimisation bug (was Re: Duron kernel 
 crash)
Cc: Roberto Jung Drebes <drebes@inf.ufrgs.br>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>effectivelly all my Athlon now wroks well using
>KT73c bios, i never upgraded to a following one, but i made a further
>check, and noticed that the first oops reports are older than this bios
>release. So there is no way that first report could be related to
>KT73r bios version. maybe also KT73n has problems.... (1.First release for
>KT7A/KT7A-RAID V
>                     1.3 or newer.)

Or, more likely, the earlier reports came from m/board vendors who 
upgraded their *base* BIOS version earlier than ABIT, or who simply 
have flakier designs which fail even under the older versions. 
Notice that the first change listed for 3R is "update BIOS code" 
which probably means the AWARD 'base' code which supports the actual 
chipset rather than Abit-specific features.

-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
