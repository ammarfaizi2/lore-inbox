Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315175AbSD2Ttq>; Mon, 29 Apr 2002 15:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315176AbSD2Ttp>; Mon, 29 Apr 2002 15:49:45 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:30848 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S315175AbSD2Ttp>; Mon, 29 Apr 2002 15:49:45 -0400
Date: Mon, 29 Apr 2002 21:49:21 +0200
Message-Id: <200204291949.g3TJnLX07366@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: Christian Neumair <christian-neumair@web.de>
To: linux-kernel@vger.kernel.org
Cc: "YoelInbar" <yoel@digitalfountain.com>
Subject: Re: vesafb scrolling problem
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be a reproducible problem as i experienced it with a geforce 2 mx, too. I didn't check it out but maybe the rewritten fb-layer introduced in the latest 2.5 series kernel fixed this. The only way i could fix this on my machine was using the vendor specific fb-driver.

see you,
 Chris

