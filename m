Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269101AbRHLLul>; Sun, 12 Aug 2001 07:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269104AbRHLLub>; Sun, 12 Aug 2001 07:50:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5133 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269101AbRHLLuS>; Sun, 12 Aug 2001 07:50:18 -0400
Subject: Re: Performance 2.4.8 is worse than 2.4.x<8
To: mikeg@wen-online.de (Mike Galbraith)
Date: Sun, 12 Aug 2001 12:52:47 +0100 (BST)
Cc: haiquy@yahoo.com (Steve Kieu), linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <Pine.LNX.4.33.0108120754020.593-100000@mikeg.weiden.de> from "Mike Galbraith" at Aug 12, 2001 09:00:54 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15VtnT-0005bM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here, disk write throughput seems to want some tweaking, and Bonnie
> doing it's rewrite test triggers a very large and persistant inactive
> shortage which shouldn't be there (imho).

This is one of the reasons I kept the 2.4.7 vm. The 2.4.8 vm is better
than 2.4.8pre but not actually better than the older VM by feel or
measurement on my test boxes

Alan
