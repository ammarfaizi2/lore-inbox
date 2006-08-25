Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWHYGNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWHYGNK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 02:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWHYGNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 02:13:10 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:37347 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750823AbWHYGNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 02:13:07 -0400
Date: Fri, 25 Aug 2006 08:07:37 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Alexey Dobriyan <adobriyan@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
In-Reply-To: <20060824170709.GO19810@stusta.de>
Message-ID: <Pine.LNX.4.61.0608250806560.7912@yvahk01.tjqt.qr>
References: <32640.1156424442@warthog.cambridge.redhat.com>
 <20060824152937.GK19810@stusta.de> <1156434274.3012.128.camel@pmac.infradead.org>
 <20060824155814.GL19810@stusta.de> <1156435216.3012.130.camel@pmac.infradead.org>
 <20060824160926.GM19810@stusta.de> <20060824164752.GC5205@martell.zuzino.mipt.ru>
 <20060824170709.GO19810@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>There's e.g. no reason to ask all users whether they want to compile all 
>I/O schedulers into their kernel.
>
The users that do not know how to handle it should not be compiling a 
kernel. If in doubt, they should read the help texts and follow the "If 
unsure" clause listed there.


Jan Engelhardt
-- 
