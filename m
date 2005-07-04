Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVGDWMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVGDWMs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 18:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVGDWMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 18:12:48 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:37613
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261725AbVGDWJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 18:09:14 -0400
Message-ID: <42C9A562.5090900@linuxwireless.org>
Date: Mon, 04 Jul 2005 16:08:50 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Jens Axboe <axboe@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Lenz Grimmer <lenz@grimmer.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp]
 IBM HDAPS Someone interested? (Accelerometer))
References: <9a8748490507031832546f383a@mail.gmail.com> <42C8D06C.2020608@grimmer.com> <20050704061713.GA1444@suse.de> <42C8C978.4030409@linuxwireless.org> <20050704063741.GC1444@suse.de> <1120461401.3174.10.camel@laptopd505.fenrus.org> <20050704072231.GG1444@suse.de> <20050704130336.GB3449@openzaurus.ucw.cz>
In-Reply-To: <20050704130336.GB3449@openzaurus.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>
>Actually, "spin disk down and keep it down" would be nice for other
>reasons. Taking computer for a jog playing mp3s from ramdisk is
>something I'd like to do...
>				Pavel
>  
>
This is exactly what I wanted to do. hdparm suspend which would send 
things to cache or buffer and then copy or get files only when needed. I 
just hope is fast enough, but we could trigger this with tilting or 
vibration and then something heavier when we find a free fall.

This driver does not exactly has to behave like Windows. It can be 
better. We always make things better.

.Alejandro
