Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbSIWNJx>; Mon, 23 Sep 2002 09:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261342AbSIWNJw>; Mon, 23 Sep 2002 09:09:52 -0400
Received: from [217.167.51.129] ([217.167.51.129]:31735 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S261297AbSIWNJn>;
	Mon, 23 Sep 2002 09:09:43 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Remco Post" <r.post@sara.nl>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.38 on ppc/prep
Date: Mon, 23 Sep 2002 03:41:22 +0200
Message-Id: <20020923014122.17320@192.168.4.1>
In-Reply-To: <97F57870-CEF4-11D6-A08A-000393911DE2@sara.nl>
References: <97F57870-CEF4-11D6-A08A-000393911DE2@sara.nl>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>very well possible. If Linus keeps up the pace on kernel releases I'll 
>just d/l 2.5.39 tomorrow and try again ;)

Well, I don't know if a fix went in yet, Paulus did a quick hack but
didn't submit a real patch as we are waiting from someone knowing
sys_mprotect() better to show up

Ben.


