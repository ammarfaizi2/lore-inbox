Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270602AbRHIW0a>; Thu, 9 Aug 2001 18:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270601AbRHIW0U>; Thu, 9 Aug 2001 18:26:20 -0400
Received: from www.transvirtual.com ([206.14.214.140]:13072 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S270602AbRHIW0P>; Thu, 9 Aug 2001 18:26:15 -0400
Date: Thu, 9 Aug 2001 15:25:44 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Louis Garcia <louisg00@bellsouth.net>
cc: Steven Walter <srwalter@yahoo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: ATI frame buffer
In-Reply-To: <997395178.8772.5.camel@tiger>
Message-ID: <Pine.LNX.4.10.10108091524520.24524-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The docs for the aty128fb states that it only supports the Rage128 based
> devices. You sure it's also for the radeon?

aty128fb does NOT work for the radeon cards!!! Their is a radeonfb.c
driver out their somewhere. I have seen it before.

