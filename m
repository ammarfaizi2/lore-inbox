Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTJTLKL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 07:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTJTLKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 07:10:11 -0400
Received: from gw-nl6.philips.com ([212.153.235.103]:44963 "EHLO
	gw-nl6.philips.com") by vger.kernel.org with ESMTP id S262543AbTJTLKH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 07:10:07 -0400
Message-ID: <3F93C2FB.6030602@basmevissen.nl>
Date: Mon, 20 Oct 2003 13:11:55 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4.1) Gecko/20030906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Saravanan Subbiah <saravanan_subbiah@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ICH5 - CMI9739A - AC'97 sound driver support
References: <1066413060.13867.24.camel@dude.saravan.dns2go.com>
In-Reply-To: <1066413060.13867.24.camel@dude.saravan.dns2go.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Saravanan Subbiah wrote:

> I am trying to make sound work in my motherboard with CMI9739A chipset.
> 
> The driver from c-media works but freezes my SMP (HT) kernel.
> 
> So I tried the i810_audio driver in 2.4.22-ac4 kernel. This driver works
> but I cannot change the volume. It always outputs at high volume
> irrespective what level I set.
> 
> I even tried alsa driver snd-intel8x0 and got the same result. no volume
> control support.'
> 

Did you try the alsa-mixer utility too? That one seems to give you 
control of all mixers available.

Bas.



