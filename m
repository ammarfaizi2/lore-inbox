Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267178AbTBDJUe>; Tue, 4 Feb 2003 04:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbTBDJUe>; Tue, 4 Feb 2003 04:20:34 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:56282 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267178AbTBDJUe>; Tue, 4 Feb 2003 04:20:34 -0500
Date: Tue, 4 Feb 2003 10:29:36 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] use 64 bit jiffies
Message-ID: <20030204092936.GA14495@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.33.0302022347440.24857-100000@gans.physik3.uni-rostock.de> <200302030644.h136iXs04935@Port.imtp.ilyichevsk.odessa.ua> <20030203082800.GT821@mea-ext.zmailer.org> <200302040643.h146gps10473@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200302040643.h146gps10473@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 February 2003 08:41:13 +0200, Denis Vlasenko wrote:
> 
> 		Jiffy Wrap Bugs
> 
> There is a better solution to ensure correct jiffy wrap handling in
> *ALL* kernel code: make jiffy wrap in first five minutes of uptime.
> Tim has a patch for such config option. This is almost right.

This sounds very interesting. Is this patch availlable somewhere? If
not, could you send a copy to me, Tim?

Jörn

-- 
When people work hard for you for a pat on the back, you've got
to give them that pat.
-- Robert Heinlein
