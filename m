Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267592AbUHPMVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267592AbUHPMVP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 08:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267580AbUHPMUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 08:20:51 -0400
Received: from shockwave.systems.pipex.net ([62.241.160.9]:57559 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S267571AbUHPMSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 08:18:32 -0400
Message-ID: <4120A612.2000600@tungstengraphics.com>
Date: Mon, 16 Aug 2004 13:18:26 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Dave Airlie <airlied@linux.ie>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: DRM and 2.4 ...
References: <Pine.LNX.4.58.0408160652350.9944@skynet> <1092640312.2791.6.camel@laptop.fenrus.com> <412081C6.20601@tungstengraphics.com> <20040816094622.GA31696@devserv.devel.redhat.com> <412088A5.6010106@tungstengraphics.com> <20040816101426.GB31696@devserv.devel.redhat.com> <Pine.LNX.4.58.0408161137330.21177@skynet> <41209DBB.1060909@tungstengraphics.com> <20040816115813.GD13029@devserv.devel.redhat.com>
In-Reply-To: <20040816115813.GD13029@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, Aug 16, 2004 at 12:42:51PM +0100, Keith Whitwell wrote:
> 
>>Dave's hit the nail on the head here.  If you'd like some changes, feel 
>>free to make suggestions.
> 
> 
> once the new intel DRM driver hits Linus' tree I want to start an experiment
> to make it look like a linux driver.. (I'm waiting for that driver since
> most of my hw is intel gfx based)

Fair enough.  Hopefully that will include Dave's changes as well, as they're 
going to resolve a lot of the issues that I find make DRM difficult to work with.

Keith

