Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWBCG1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWBCG1x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 01:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWBCG1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 01:27:53 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:23264 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751260AbWBCG1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 01:27:52 -0500
Message-ID: <43E2F667.8020404@colorfullife.com>
Date: Fri, 03 Feb 2006 07:21:27 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: Andrew Morton <akpm@osdl.org>, "Kevin O'Connor" <kevin@koconnor.net>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: Size-128 slab leak
References: <20060131024928.GA11395@double.lan>	 <20060201231001.0ca96bf0.akpm@osdl.org> <84144f020602012332g57a58f0aw373983fc6bc7368b@mail.gmail.com>
In-Reply-To: <84144f020602012332g57a58f0aw373983fc6bc7368b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:

>We already have last caller in dbg_userword. Manfred, is there a
>reason we're not using it?
>
>  
>
IIRC only due to historical reasons: dbg_userword is newer than this patch.

--
    Manfred
