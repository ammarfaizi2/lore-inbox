Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVK3VX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVK3VX6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 16:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVK3VX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 16:23:58 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:54798 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750729AbVK3VX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 16:23:57 -0500
Date: Wed, 30 Nov 2005 22:23:50 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Chris Boot <bootc@bootc.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] un petite hack: /proc/*/ctl
Message-ID: <20051130212350.GV11266@alpha.home.local>
References: <20051129002801.GA9785@mipter.zuzino.mipt.ru> <D6440692-33C3-45F0-9112-C22332ED7072@bootc.net> <20051129013354.GA17749@mipter.zuzino.mipt.ru> <20051129054819.GR11266@alpha.home.local> <20051130102111.GK9949@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051130102111.GK9949@vanheusden.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 11:21:11AM +0100, Folkert van Heusden wrote:
> > > Not that I'm seriously proposing patch for inclusion.
> > so please don't pollute the list with useless patches that take time
> > to review.
> 
> Are you theo de raadt's nephew?

not at all. It's just that patches on the list take more and more time
to check, we're around something like 1 patch for 5 mails. And when the
author himself suggests that the patch is not for inclusion, it wastes
time. However, I agree that Alexey announced it as [RFC] and not [PATCH],
so he proceeded correctly and I was wrong to yell at him (that's why I
apologised when I noticed this). But generally speaking, I do not find
it very constructive to send random work in which even the author does
not believe. It only lowers the SNR.

> Folkert van Heusden

Regards,
Willy

