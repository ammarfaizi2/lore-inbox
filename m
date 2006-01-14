Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbWANLKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWANLKT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 06:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWANLKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 06:10:19 -0500
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96]:5055 "EHLO
	localhost") by vger.kernel.org with ESMTP id S1751757AbWANLKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 06:10:18 -0500
Message-ID: <43C8DC6E.3040902@free.fr>
Date: Sat, 14 Jan 2006 12:11:42 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: greg@kroah.com, linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net, ueagle <ueagleatm-dev@gna.org>
Subject: Re: [PATCH] UEAGLE : add iso support and commestic stuff
References: <43C7E8A2.1000605@free.fr> <20060113184441.GA7951@mipter.zuzino.mipt.ru>
In-Reply-To: <20060113184441.GA7951@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> On Fri, Jan 13, 2006 at 06:51:30PM +0100, matthieu castet wrote:
> 
>>this patch mainly adds the support for isochronous pipe.
>>There are also some cosmetic stuff (please tell me if you want them in a
>>extra patch).
> 
> 
> This patch should be shrinked by >50% by dropping unrelated changes.
> It'd make it much easier to read.
Ok, let's split the patch in iso and comestic stuff.
