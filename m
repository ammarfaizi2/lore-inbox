Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267595AbTA3ShU>; Thu, 30 Jan 2003 13:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267598AbTA3ShU>; Thu, 30 Jan 2003 13:37:20 -0500
Received: from postal2.lbl.gov ([131.243.248.26]:37288 "EHLO postal2.lbl.gov")
	by vger.kernel.org with ESMTP id <S267595AbTA3ShT>;
	Thu, 30 Jan 2003 13:37:19 -0500
Message-ID: <3E39730D.3090009@lbl.gov>
Date: Thu, 30 Jan 2003 10:46:37 -0800
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021017
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre4
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>	 <3E384D41.9080605@lbl.gov>	 <1043926998.28133.21.camel@irongate.swansea.linux.org.uk>	 <3E395C30.6040903@lbl.gov>	 <1043950661.31674.12.camel@irongate.swansea.linux.org.uk>	 <3E396032.2000503@lbl.gov>	 <1043951291.31674.17.camel@irongate.swansea.linux.org.uk>	 <3E39669F.20302@lbl.gov> <1043955332.31674.27.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Thu, 2003-01-30 at 17:53, Thomas Davis wrote:
>
> >ie, it has a ac97 support in the driver, it calls ac97_probe_codec?
> >
> >Is that enough or not?
>
>
> The codec and the sound card are two seperate things. The FM801
> hardware has an AC97 digital interface that talks to a codec chip
> of which there are a considerable number. Which one depends on
> who made the specific board you have. The ac97 side isnt part
> of the FM801 any more than a PC motherboard automatically
> has an Intel CPU
>

Ok, fine.

How do I get the name in there other than "Unknown"?

It's a single chip card.

Thanks.

thomas

