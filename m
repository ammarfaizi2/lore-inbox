Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVHATC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVHATC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVHATCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:02:55 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:62504 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261169AbVHATCt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:02:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sFjshUeR8uIXTGz+j/+Mgs985WXZ31qlwPjJVqGZmAb/xjvY6kly+XDMQc5jn8BnDJqPSYQ+091NvqPvxWqYJRWYkSmJMPLiXr5EeEnrKZeaGotMoLDETtUmTH62aqOmmfyTM2bdq7k/6LarQdVCa9MPnKyJ3dw42EyHDwKRqdk=
Message-ID: <2538186705080112025ec78daa@mail.gmail.com>
Date: Mon, 1 Aug 2005 15:02:48 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
Subject: Re: IBM HDAPS, I need a tip.
Cc: abonilla@linuxwireless.org, Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <1122903488.17231.48.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1122861215.11148.26.camel@localhost.localdomain>
	 <1122872189.5299.1.camel@localhost.localdomain>
	 <1122873057.15825.26.camel@mindpipe>
	 <Pine.LNX.4.61.0508010844380.6353@yvahk01.tjqt.qr>
	 <25381867050801010710af48d6@mail.gmail.com>
	 <1122903488.17231.48.camel@localhost>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/05, Dave Hansen <dave@sr71.net> wrote:
> On Mon, 2005-08-01 at 04:07 -0400, Yani Ioannou wrote:
> > Well don't forget there is a bios 'calibration' routine that you will
> > see on start up (especially if you are on a moving vehicle/train).
> 
> I've never seen that.  Could you please elaborate on what you see, and
> when?
> 

Sorry it says diagnostics, not calibration, but the way it behaves
leads me to believe its doing some sort of calibration. If you boot up
your thinkpad, get rid of your bios splash screen (esc), and tilt the
thinkpad back and forth you will see something about IBM Active
Protection diagnostics running and a spinner. If you keep tilting the
notebook back and forth you can actually prevent the machine from
booting because this will fail after a while. Normally you won't see
it, I mainly notice it while in a train or car.

Yani
