Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265576AbSJSJST>; Sat, 19 Oct 2002 05:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265573AbSJSJST>; Sat, 19 Oct 2002 05:18:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58062 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265570AbSJSJSO>;
	Sat, 19 Oct 2002 05:18:14 -0400
Date: Sat, 19 Oct 2002 11:24:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Jan Dittmer <jan@jandittmer.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: Oops on boot with TCQ enabled (VIA KT133A)
Message-ID: <20021019092406.GI871@suse.de>
References: <200210190241.49618.jan@jandittmer.de> <20021019091518.GG871@suse.de> <200210191124.34977.jan@jandittmer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210191124.34977.jan@jandittmer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19 2002, Jan Dittmer wrote:
> > But I'm curious about TCQ on your system, since another VIA user
> > reported problems. Does it appear to work for you?
> 
> Actually that was me, I think. It now seems to work without any corruption on 

Oh :)

> 2.5.44bk. I don't know what caused it last time. Perhaps it was really my 
> harddisk dying - but I never experienced such problems with 2.4.x .
> So I guess it's okay now. I'll try re-enable tcq now...

Thanks for testing!

-- 
Jens Axboe

