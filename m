Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVGISkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVGISkR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 14:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVGISj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 14:39:59 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:7659 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261694AbVGISj2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 14:39:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=iIkVTXjBp0HmDpfNQ6o8KiHqJtSWfNsrDz0KQ1Lvm+xVAmu+gEnjdUScofFiDI55djTVphsGl03luFvS/OfhNrJUdu7mIkrzQEWrp/VWBv2OU68VLCtvbTlK3QyJQfvHyqpI8BvtEfqrpNyyA541eCJzil0VjE39mwcob0LZU+A=
Date: Sat, 9 Jul 2005 20:39:20 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-Id: <20050709203920.394e970d.diegocg@gmail.com>
In-Reply-To: <1120932991.6488.64.camel@mindpipe>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	<20050708214908.GA31225@taniwha.stupidest.org>
	<20050708145953.0b2d8030.akpm@osdl.org>
	<1120928891.17184.10.camel@lycan.lan>
	<1120932991.6488.64.camel@mindpipe>
X-Mailer: Sylpheed version 2.0.0beta4 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 09 Jul 2005 14:16:31 -0400,
Lee Revell <rlrevell@joe-job.com> escribió:

> I still think you're absolutely insane to change the default in the
> middle of a stable kernel series.  People WILL complain about it.


Lots of people have switched from 2.4 to 2.6 (100 Hz to 1000 Hz) with no impact in
stability, AFAIK. (I only remember some weird warning about HZ with debian woody's
ps).
