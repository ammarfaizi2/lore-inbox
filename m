Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317387AbSGTGl2>; Sat, 20 Jul 2002 02:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317390AbSGTGl2>; Sat, 20 Jul 2002 02:41:28 -0400
Received: from pop016pub.verizon.net ([206.46.170.173]:54456 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S317387AbSGTGl1>; Sat, 20 Jul 2002 02:41:27 -0400
Message-Id: <200207200652.g6K6q7rn001868@pool-141-150-241-241.delv.east.verizon.net>
Date: Sat, 20 Jul 2002 02:51:59 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Impressions of IDE 98?
References: <Pine.LNX.4.44.0207192249500.3378-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207192249500.3378-100000@hawkeye.luckynet.adm>; from thunder@ngforever.de on Fri, Jul 19, 2002 at 10:51:26PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill wrote:
> I don't have any IDE machines handy, and since these problems that IDE had 
> in the last days, I wonder what's become of it. Has anyone been so brave 
> as to try out 2.5.26 w/the included IDE (IDE 98)? How is it?

I was able to freeze 2.5.25 regularly (locking issues?) by trying to
move large files between different filesystems on the same drive.

IDE 98 in 2.5.26 handles that fine and hasn't locked up a single
time in normal use.

-- 
Skip
