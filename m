Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263121AbUJ2HW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbUJ2HW0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 03:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbUJ2HWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 03:22:25 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:2228 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S263121AbUJ2HWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 03:22:23 -0400
Date: Fri, 29 Oct 2004 09:22:11 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nathan Scott <nathans@sgi.com>
cc: Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: best linux kernel with memory management
In-Reply-To: <20041029071429.GF1246@frodo>
Message-ID: <Pine.LNX.4.53.0410290921260.29032@yvahk01.tjqt.qr>
References: <412C87F3.2030602@ribosome.natur.cuni.cz> <20040825114005.GB13285@logos.cnet>
 <412C94F5.4010902@ribosome.natur.cuni.cz> <20040825120450.GA22509@logos.cnet>
 <412C9D9C.6060703@ribosome.natur.cuni.cz> <20040827121905.GG32707@logos.cnet>
 <417F6258.7010209@ribosome.natur.cuni.cz> <20041028105108.GB5741@logos.cnet>
 <20041029071429.GF1246@frodo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > >>>>kernel worked fine. Also 2.4.25 had problems which was on Gentoo
>> > >>>>install CDROM. I don't remember exact their exact revisions, but I
>> > >>>>shouldn't have used xfs also for /. I thought better xfs everywhere
>> > >>>>than combined with reiserfs. Of course, /boot is ext3.
>
>There should be no problems using XFS for everything, including
>/boot - I do that on all my systems (for a few years now).

/boot (whose root is / for me) can be reiser, the bootload installer just needs
to know that is has to unpack files otherwise they might not boot.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
