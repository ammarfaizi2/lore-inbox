Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264025AbTCXQZz>; Mon, 24 Mar 2003 11:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264033AbTCXQZz>; Mon, 24 Mar 2003 11:25:55 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:40100 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S264025AbTCXQZy>;
	Mon, 24 Mar 2003 11:25:54 -0500
Subject: Re: [2.4.21-pre5] compile error in ip_conntrack_ftp.c:440:
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Andreas Metzler <ametzler@logic.univie.ac.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b5n43a$djn$1@main.gmane.org>
References: <b44s65$pdl$1@main.gmane.org>
	 <61rskxlnt.ln2@elmicha.333200002251-0001.dialin.t-online.de>
	 <b5n43a$djn$1@main.gmane.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048523819.14737.7.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Mar 2003 17:37:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-24 at 15:18, Andreas Metzler wrote:

> Hello,
> This fixes neither the example I posted (add this line to initial
> minimal config, make menuconfig, make clean dep, make modules), nor the
> real world example
> 
> http://www.logic.univie.ac.at/~ametzler/2.4.20.breaks.config

Hi,

I'll take a look at this later today, I think there are more problems
than this in the config-dependencies, I'll go over 2.4 and 2.5 and see
what I find.
 
-- 
/Martin
