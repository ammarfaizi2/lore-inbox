Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266995AbTALOHG>; Sun, 12 Jan 2003 09:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbTALOHF>; Sun, 12 Jan 2003 09:07:05 -0500
Received: from tag.witbe.net ([81.88.96.48]:29960 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S266995AbTALOHF>;
	Sun, 12 Jan 2003 09:07:05 -0500
From: "Paul Rolland" <rol@witbe.net>
To: "'Jaroslav Kysela'" <perex@perex.cz>
Cc: <linux-kernel@vger.kernel.org>, <Perex@suze.cz>, <rol@as2917.net>
Subject: Re: [PATCH 2.5.56] Sound core not compiling without /proc support
Date: Sun, 12 Jan 2003 15:15:52 +0100
Organization: Witbe.net
Message-ID: <00a201c2ba45$1db90650$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <Pine.LNX.4.33.0301121458540.611-100000@pnote.perex-int.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > Here is a quick patch to allow sound support to compile 
> correctly when 
> > not using /proc support.
> 
> It's a bad fix. The null function declarations should go to 
> include/sound/info.h.
> 
As I wrote, it is a "quick fix".
Sure there are better way to do it, my intention was mainly :
 - to mention the problem,
 - give a quick (though dirty) workaround for people missing it.

Paul

