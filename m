Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751985AbWCNBbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbWCNBbx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbWCNBbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:31:53 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:729 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751985AbWCNBbw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:31:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CJU2tCBAocHG40DNMPGbb6NUp5Q45nil16g018RcSBGQy/+gC0edqMyn56IAUfIPYY+Qm08GPMJ8yEwAWzSKB0b2Qm++ynXUAEcDYPIsZFN8PPT1aMtNWnubWk7Kz7sHxe5lBVKfFOl3/ajaDLTHyNwabKx9ZD8psZIgqIBgdMQ=
Message-ID: <436c596f0603131731w172bb28cr43eec5e5bb32bf25@mail.gmail.com>
Date: Mon, 13 Mar 2006 22:31:51 -0300
From: j4K3xBl4sT3r <jakexblaster@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel config problem between 2.4.x to 2.6.x!
In-Reply-To: <1142297572.7090.4.camel@shogun.daga.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436c596f0603121015j2a091ab2sf43d0c5c396bbb72@mail.gmail.com>
	 <7c3341450603121247n7afe018m@mail.gmail.com>
	 <436c596f0603121632qe3151k793fd3ccd9a0eacb@mail.gmail.com>
	 <200603130708.13685.nick@linicks.net>
	 <436c596f0603130342u4d38445bt5e9f129349cda0c8@mail.gmail.com>
	 <1142297572.7090.4.camel@shogun.daga.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/06, Chris Largret <largret@gmail.com> wrote:
> On Mon, 2006-03-13 at 08:42 -0300, j4K3xBl4sT3r wrote:
>
> > 1. before, the mouse worked fine. now, it doesnt works
> > 2. before, the sound worked. and now, still working, just with ALSA,
> > no OSS support (tested with mpg321 and ogg123 on bash terminal)
> > 3. strangely, the X worked fine after the kernel update, is DRM and
> > AGPGART needed by Xorg?
> > 4. before, the PPPoE connected within the 2 first "." (seconds?). Now,
> > doesnt work, I always get TIMEOUT from PPPoE.
> > 5. the PNPDUMP returns a empty file on the isapnptools (from the
> > compilation, this is the only file that gets fully compiled)
> >
> > This situation happened on the Slackware 10.2, assuming a Kernel
> > Update.
>
> I'm running Slackware 10.2 on my server with the 2.6 kernel. Did you
> remember to chmod +x /etc/rc.d/rc.udev? It is either an issue with /dev
> or an issue with the drivers not being initialized correctly.
>
> --
> Chris Largret <http://daga.dyndns.org>
>
>

doesnt matter executing the rc.udev, I run udevd and udevstart on my
system. and doesnt work =S
