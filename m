Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSHYK6k>; Sun, 25 Aug 2002 06:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317232AbSHYK6j>; Sun, 25 Aug 2002 06:58:39 -0400
Received: from 203-79-122-66.cable.paradise.net.nz ([203.79.122.66]:1029 "EHLO
	ruru.local") by vger.kernel.org with ESMTP id <S317194AbSHYK6i>;
	Sun, 25 Aug 2002 06:58:38 -0400
Date: Sun, 25 Aug 2002 23:02:51 +1200
From: Volker Kuhlmann <list0570@paradise.net.nz>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] make localconfig
Message-ID: <20020825110251.GF11740@paradise.net.nz>
References: <Pine.LNX.4.44.0208241522061.3234-100000@hawkeye.luckynet.adm> <Pine.LNX.4.44.0208251256130.28574-100000@linux-box.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208251256130.28574-100000@linux-box.realnet.co.sz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I just think it might save you some time when you've accidently rm'd your 
> > .config, and all you want to have is a .config for the local box. Also 
> > wouldn't I load all the modules one by one, possibly.

> For this kind of thing, code talks. Otherwise no one will take heed.

Even with code noone seems to have taken heed. The code has been
available for ages. I think it's very useful. gunzip </proc/config.gz
gives you the config of the running kernel, make cloneconfig sets up
the source tree. Free and convenient with every SuSE kernel.

Volker

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.orcon.net.nz/		Please do not CC list postings to me.

