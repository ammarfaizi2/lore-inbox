Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271126AbTGPVJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271148AbTGPVJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:09:47 -0400
Received: from ip45.usw1.rb1.pdx.nwlink.com ([207.202.132.45]:14473 "EHLO
	consumption.net") by vger.kernel.org with ESMTP id S271126AbTGPVIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:08:55 -0400
Date: Wed, 16 Jul 2003 14:23:48 -0700 (PDT)
From: <crozierm@consumption.net>
To: linux-kernel@vger.kernel.org
Subject: Re: USB mouse "hang" with 2.5.75
In-Reply-To: <20030715212956.GA5524@kroah.com>
Message-ID: <Pine.LNX.4.21.0307161421250.11285-100000@consumption.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another symptom/workaround for this problem is that reading
/proc/bus/usb/devices causes the mouse start working again.

Easier than re-plugging the mouse, at any rate.

> > Should it be possible for X to lock up the mouse?  When the mouse stops
> > working in X, it seems to stop working for everything else too (the "cat
> > /dev/input/mice" test, at least).
> 
> Hm, don't really know, sorry.


