Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265362AbUFRQCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbUFRQCx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 12:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265343AbUFRP7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:59:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47552 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265285AbUFRP57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:57:59 -0400
Message-ID: <40D310F5.2050706@pobox.com>
Date: Fri, 18 Jun 2004 11:57:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hetfield666@virgilio.it
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.x ALSA sound is pretty broken
References: <1087567432.9282.17.camel@blight.blight> <1087567977.9285.21.camel@blight.blight>
In-Reply-To: <1087567977.9285.21.camel@blight.blight>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hetfield wrote:
> i forgot to say that some applications doesn't work properly
> 
> example: "beep"  when i execute beep i hear no sounds, neither from speakers (audio card)
> nor from internal pc speaker.

This has nothing to do with ALSA -- you are probably not loading the PC 
speaker driver.

	Jeff

