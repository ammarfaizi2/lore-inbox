Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265193AbUABGye (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 01:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUABGye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 01:54:34 -0500
Received: from skintwin.microway.com ([64.80.227.45]:47561 "EHLO
	skintwin.microway.com") by vger.kernel.org with ESMTP
	id S265193AbUABGyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 01:54:33 -0500
Message-ID: <3FF514D6.2070701@mail.ru>
Date: Fri, 02 Jan 2004 01:51:02 -0500
From: Yaroslav Klyukin <skintwin@mail.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Diego Calleja <grundig@teleline.es>, linux-kernel@vger.kernel.org
Subject: Re: best AMD motherboard for Linux
References: <17Mr0-3MN-9@gated-at.bofh.it> <17MTX-4tr-5@gated-at.bofh.it> <17Mr0-3MN-9@gated-at.bofh.it> <17NmT-53G-1@gated-at.bofh.it> <1894e-34n-11@gated-at.bofh.it> <18wWI-5xF-5@gated-at.bofh.it> <18y2M-7Zy-15@gated-at.bofh.it> <18CSr-880-1@gated-at.bofh.it> <18L9o-5xr-5@gated-at.bofh.it> <194lF-8q6-3@gated-at.bofh.it> <19euJ-59K-7@gated-at.bofh.it> <19gZu-8vz-1@gated-at.bofh.it>
In-Reply-To: <19gZu-8vz-1@gated-at.bofh.it>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
> And if anyone had a tdfx card in a powerpc machine, they could use it.
> Unlike the propietary drivers: you have to use the framebuffer in your
> ibook (with linux) because you don't have drivers for PPC. However,
I have iBook with ATI video. IMHO, the use of framebuffer in _text_ mode is required, because of lack of fonts.
As for graphical mode, ati.2 AKA ?gatos? drivers work just fine.
It took me some struggle, before I could make this video card play movies with mplayer. Standard ati or radeon drivers, which
come with 4.3.0 XFree86 had have poor performance. Now I can play fullscreen on 600Mhz PPC CPU.
> Mac OS X has them....


