Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbTA0WoH>; Mon, 27 Jan 2003 17:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264654AbTA0WoH>; Mon, 27 Jan 2003 17:44:07 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:942 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264630AbTA0WoG>;
	Mon, 27 Jan 2003 17:44:06 -0500
Date: Mon, 27 Jan 2003 22:50:05 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.21-pre3-jam3
Message-ID: <20030127225005.GA9646@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Bill Davidsen <davidsen@tmr.com>,
	"J.A. Magallon" <jamagallon@able.es>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030126003309.GG1507@werewolf.able.es> <Pine.LNX.3.96.1030127171313.27928J-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030127171313.27928J-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 05:18:35PM -0500, Bill Davidsen wrote:

 > > - killed cd-read-audio-dma, because it was giving too much oopses...
 > Is someone working on this (assuming it will eventually get into 2.6)? It
 > seems to make a worthwhile improvement when ripping CDs. Not as worthwhile
 > as stability, obviously ;-)

Went in a while back. See http://lwn.net/Articles/13538/ & http://lwn.net/Articles/13160/
for more info.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
