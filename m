Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317694AbSHYX72>; Sun, 25 Aug 2002 19:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317698AbSHYX71>; Sun, 25 Aug 2002 19:59:27 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35578 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317694AbSHYX71>; Sun, 25 Aug 2002 19:59:27 -0400
Subject: Re: kernel losing time
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: erik@debill.org
Cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020825215515.GA2965@debill.org>
References: <20020825105500.GE11740@paradise.net.nz>
	<Pine.LNX.4.44.0208250459500.3234-100000@hawkeye.luckynet.adm> 
	<20020825215515.GA2965@debill.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 26 Aug 2002 01:05:14 +0100
Message-Id: <1030320314.16766.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-25 at 22:55, erik@debill.org wrote:
> Would this explain my computer losing 2-3 minutes of time while
> ripping a cd?  Normally it's dead on (w/ ntpd running to guarantee
> that) but while ripping or burning it loses so badly ntpd can't keep
> up.

Could be - does hdparm -u1 on that device fix it ?

