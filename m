Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbSIWN25>; Mon, 23 Sep 2002 09:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbSIWN25>; Mon, 23 Sep 2002 09:28:57 -0400
Received: from [217.167.51.129] ([217.167.51.129]:12537 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S261395AbSIWN25>;
	Mon, 23 Sep 2002 09:28:57 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Remco Post" <r.post@sara.nl>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.38 on ppc/prep
Date: Mon, 23 Sep 2002 04:00:39 +0200
Message-Id: <20020923020039.27908@192.168.4.1>
In-Reply-To: <348D72FE-CEF8-11D6-A08A-000393911DE2@sara.nl>
References: <348D72FE-CEF8-11D6-A08A-000393911DE2@sara.nl>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I saw Paulus' post a few days ago. I'm fully aware that 2.5 is not ready 
>for anything serious yet on ppc, I just became curious to know if I 
>could get it to compile and run. I'll just keep on trying and posting 
>small patches that I need to compile things. I don't have the time to do 
>any real hacking, but a small patch now and then is doable ;-)

Well, if you plan to post PPC related patches, please do so on
the linuxppc-dev list (or CC it at least) so we can know what you
are doing. We do maintain a linuxppc-2.5 bk tree which is regulary
merged with Linux but contains our up-to-date fixes for PPC.
It compiles and runs most of the time (thanks Paulus for maintaining
it)

Ben.


