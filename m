Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbTDOMXR (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTDOMXR 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:23:17 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26558
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261323AbTDOMXQ (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 08:23:16 -0400
Subject: Re: ac97, alc101+kt8235 sound
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benson Chow <blc+lkml@q.dyndns.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304150537330.28926-100000@q.dyndns.org>
References: <Pine.LNX.4.44.0304150537330.28926-100000@q.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050406611.27745.34.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Apr 2003 12:36:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-15 at 12:49, Benson Chow wrote:
> hoping that these via chips were pretty close.  Unfortunately no, it
> still doesn't work.  It did, however, find the AC97 codec fine (I added
> some printk's), but no sound is produced.  Any ideas on how to get this
> vt8235-based motherboard sound working?  (and ALSA-0.9.2 seems to do
> nothing but segfault it seems.)

See 2.4.21pre - that has the driver for VIA8233/5


