Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264901AbUAOAkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 19:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbUAOAkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 19:40:12 -0500
Received: from smtpq3.home.nl ([213.51.128.198]:47257 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S264901AbUAOAj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 19:39:57 -0500
Message-ID: <4005E083.7050409@keyaccess.nl>
Date: Thu, 15 Jan 2004 01:36:19 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: Takashi Iwai <tiwai@suse.de>, Santiago Garcia Mantinan <manty@manty.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: ALSA in 2.6 failing to find the OPL chip of the sb
 cards
References: <20040107212916.GA978@man.manty.net> <s5hy8sixsor.wl@alsa2.suse.de> <20040109171715.GA933@man.manty.net> <s5hn08xgh06.wl@alsa2.suse.de> <20040109201423.GA1677@man.manty.net> <3FFFA8C3.6040609@keyaccess.nl> <4000E030.2020500@keyaccess.nl> <s5hr7y5b2oe.wl@alsa2.suse.de> <20040113232940.GC3188@neo.rr.com> <20040114190721.GD3188@neo.rr.com>
In-Reply-To: <20040114190721.GD3188@neo.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay wrote:

>>I agree with the overall strategy of the patch, but, during testing, I was able
>>to uncover a few bugs introduced by it.  I'm reworking how pnp handles flags
>>and should have an updated patch out soon.
> 
> Here's the patch.  Any testing would be appreciated.

Yes, works great for the AWE64 OPL3 issue. Many thanks. I'll test this 
on a few more machines with ISA PnP cards as well.

Rene.

