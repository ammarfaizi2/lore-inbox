Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWHYGcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWHYGcj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 02:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWHYGcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 02:32:39 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:19891 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964850AbWHYGci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 02:32:38 -0400
Date: Fri, 25 Aug 2006 08:23:28 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: David Woodhouse <dwmw2@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Adrian Bunk <bunk@stusta.de>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
In-Reply-To: <20060824175922.GA22586@uranus.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0608250822090.7912@yvahk01.tjqt.qr>
References: <20060824152937.GK19810@stusta.de> <1156434274.3012.128.camel@pmac.infradead.org>
 <20060824155814.GL19810@stusta.de> <1156435216.3012.130.camel@pmac.infradead.org>
 <20060824160926.GM19810@stusta.de> <20060824164752.GC5205@martell.zuzino.mipt.ru>
 <20060824170709.GO19810@stusta.de> <1156439763.3012.155.camel@pmac.infradead.org>
 <20060824103459.77e5569c.rdunlap@xenotime.net> <1156441724.3012.183.camel@pmac.infradead.org>
 <20060824175922.GA22586@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Here meuconfig can be a great help for you. Trying the help option
>tells you a bit more about what needs to be done to disable
>a given option.

Some nitpick: when there are a lot of dependencies or a long select 
or long selected by list, you need to scroll far to the right, and possibly 
back left again. This takes time because the normal user set a keyboard 
repeat rate at about 30. (Under X, I prefer 35, but that's unfortunately 
not available on 80x25/console/tty1.)
These lines should be wrapped



Jan Engelhardt
-- 
