Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVGDS7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVGDS7E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 14:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVGDS7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 14:59:04 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:10166 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261566AbVGDS7C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 14:59:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YrBx+HSPi4lt4+wgnrwK6ymKSHSBGAKvy3CqoxdWxpoHQe4JPKDB3DtgBCSgDG+NbstBSeFrfSdY2Mkn4ecNdpU2MuKHjrNUykKgrS6LSVCwaHacF0tblMSHa9aMzSmK5ApBo3KzZcJG4O1+YRlPTJ29GJXaDoGGla71dsbmYIQ=
Message-ID: <727e501505070411594cac3c45@mail.gmail.com>
Date: Mon, 4 Jul 2005 13:59:01 -0500
From: Aaron Cohen <remleduff@gmail.com>
Reply-To: aaron@assonance.org
To: Jens Axboe <axboe@suse.de>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Cc: Lenz Grimmer <lenz@grimmer.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050704061713.GA1444@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490507031832546f383a@mail.gmail.com>
	 <42C8D06C.2020608@grimmer.com> <20050704061713.GA1444@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/05, Jens Axboe <axboe@suse.de> wrote:
> Generel observation on this driver - why isn't it just contained in user
> space? You need to do the monitoring and sending of ide commands from
> there anyways, I don't see the point of putting it in the kernel.
> 

Can't the accelerometer be used as an input device in addition to just
being a "about to fall detector?"

I seem to remember games where the the input method involved tilting
the device in the direction you want a marble to roll or something
like that.
