Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbTENOXr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbTENOXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:23:47 -0400
Received: from 7.Red-80-37-235.pooles.rima-tde.net ([80.37.235.7]:53683 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id S262268AbTENOXq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:23:46 -0400
Date: Wed, 14 May 2003 16:36:26 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
cc: Ahmed Masud <masud@googgun.com>, walt <wa1ter@myrealbox.com>
Subject: Re: cannot boot 2.5.69
In-Reply-To: <Pine.LNX.4.33.0305141025010.10993-100000@marauder.googgun.com>
Message-ID: <Pine.LNX.4.44.0305141633540.1872-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Ahmed Masud wrote:

> On Wed, 14 May 2003, walt wrote:
> 
> > Pau Aliagas wrote:
> > > I still find no way to boot a 2.5.69 kernel.
> > > It reports: "no console found, specify init= option"
> 
> Looks as if init can't seem to find the device node file... Check your
> /dev to see if there is a console entry there:
> 
> 	/dev/console c 5 1

That's exactly what I have and still no way.

> This isn't a kernel issue.

Well, I'm looking for a bit of help to test 2.5 kernels in several 
machines (laptops, servers, desktops) because I have not been able to 
solve this problem.

Pau

