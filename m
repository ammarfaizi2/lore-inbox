Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbVIQDkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbVIQDkA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 23:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVIQDkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 23:40:00 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:3032
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1750839AbVIQDkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 23:40:00 -0400
Subject: Re: R52 hdaps support?
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Reply-To: abonilla@linuxwireless.org
To: Keenan Pepper <keenanpepper@gmail.com>
Cc: Robert Love <rml@novell.com>, linux-kernel@vger.kernel.org
In-Reply-To: <432B7EE6.1040905@gmail.com>
References: <432B34D6.6010904@gmail.com> <1126911860.24266.1.camel@phantasy>
	 <432B7EE6.1040905@gmail.com>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 21:39:53 -0600
Message-Id: <1126928394.5461.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-16 at 22:26 -0400, Keenan Pepper wrote:
> Robert Love wrote:
> > The R52 should work and nothing should break.  If it works, I'll add it.
> > 
> > As for normal versus inverted: You probably want NORMAL, but you will
> > have to verify it and let me know.  You'll know you have the wrong one
> > when the readings are, well, inverted.
> > 
> > 	Robert Love
> 
> OK, it's compiled and running, but how do I tell if it's inverted? The laptop is 
> on a horizontal surface and /sys/devices/platform/hdaps/position reads 
> (482,508). What does that mean?
> 
> Keenan Pepper
Keenan,

	You may try using the hdaps-gl located at the hdaps.sf.net download
section which will take you to the SF Repository.

.Alejandro

