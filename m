Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbUJ0MOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbUJ0MOT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 08:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbUJ0MOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 08:14:19 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:17891 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262401AbUJ0MOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 08:14:09 -0400
Date: Wed, 27 Oct 2004 14:13:43 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>
Subject: Re: Strange IO behaviour on wakeup from sleep
In-Reply-To: <1098878790.9478.11.camel@gaston>
Message-ID: <Pine.LNX.4.53.0410271412220.10957@gockel.physik3.uni-rostock.de>
References: <1098845804.606.4.camel@gaston> 
 <Pine.LNX.4.53.0410271308360.9839@gockel.physik3.uni-rostock.de>
 <1098878790.9478.11.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Benjamin Herrenschmidt wrote:

> The problem has been observed on ppc, while this patch only affects
> i386...

Oops, sorry for the noise.

Still need to check whether this patch is a problem or not.

Tim
