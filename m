Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265569AbSJSJRf>; Sat, 19 Oct 2002 05:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265564AbSJSJRf>; Sat, 19 Oct 2002 05:17:35 -0400
Received: from rztsun.rz.tu-harburg.de ([134.28.200.14]:7376 "EHLO
	rztsun.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id <S265569AbSJSJRd> convert rfc822-to-8bit; Sat, 19 Oct 2002 05:17:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jan Dittmer <jan@jandittmer.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Oops on boot with TCQ enabled (VIA KT133A)
Date: Sat, 19 Oct 2002 11:24:34 +0200
User-Agent: KMail/1.4.3
References: <200210190241.49618.jan@jandittmer.de> <20021019091518.GG871@suse.de>
In-Reply-To: <20021019091518.GG871@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210191124.34977.jan@jandittmer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But I'm curious about TCQ on your system, since another VIA user
> reported problems. Does it appear to work for you?

Actually that was me, I think. It now seems to work without any corruption on 
2.5.44bk. I don't know what caused it last time. Perhaps it was really my 
harddisk dying - but I never experienced such problems with 2.4.x .
So I guess it's okay now. I'll try re-enable tcq now...

thanks,

jan

