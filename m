Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbVAESix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbVAESix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 13:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVAESiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 13:38:52 -0500
Received: from math.ut.ee ([193.40.5.125]:58617 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262558AbVAESim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 13:38:42 -0500
Date: Wed, 5 Jan 2005 20:38:34 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9+ keyboard LED problem
In-Reply-To: <200501051328.37849.dtor_core@ameritech.net>
Message-ID: <Pine.SOC.4.61.0501052035430.9146@math.ut.ee>
References: <Pine.SOC.4.61.0501051856090.9146@math.ut.ee>
 <200501051328.37849.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Seems to work fine here. The led is blinking rapidly but I can type just
> fine and touchpad works as well.
>
> What kind of box do you have? UP/SMP, Preempt?

UP, Celeron 900 on i815. Happens on 2 identical computers, one preempt, 
one not preempt. PS/2 keyboard and mouse on one, only PS/2 keyboard on 
the other (and USB mouse that is probably unimportant).

-- 
Meelis Roos
