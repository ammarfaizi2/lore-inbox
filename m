Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265123AbSLBWpQ>; Mon, 2 Dec 2002 17:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265125AbSLBWpQ>; Mon, 2 Dec 2002 17:45:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61451 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265123AbSLBWpP>;
	Mon, 2 Dec 2002 17:45:15 -0500
Message-ID: <3DEBE41D.4090009@pobox.com>
Date: Mon, 02 Dec 2002 17:52:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hps@intermeta.de
CC: linux-kernel@vger.kernel.org
Subject: Re: LM sensors into kernel?
References: <200212021842.gB2Igou00740@devserv.devel.redhat.com> <Pine.LNX.3.96.1021202140938.433H-100000@gatekeeper.tmr.com> <asgn0v$tm$1@forge.intermeta.de>
In-Reply-To: <asgn0v$tm$1@forge.intermeta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henning P. Schmiedehausen wrote:
> Bill Davidsen <davidsen@tmr.com> writes:
> 
> 
>>Okay, thanks. I was hoping since lm_sensors were proposed before the
>>freeze, relatively stable, and highly useful that they might get in.
> 
> 
> As most of the I2C code is in, I would consider the lm_sensors mainly
> as "drivers" so they wouldn't be hit by the freeze. 


To tangent a bit, I was somewhat disappointed when the I2C kernel 
merging guy disappeared... :(

