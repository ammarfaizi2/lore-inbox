Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSGYOxv>; Thu, 25 Jul 2002 10:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSGYOxv>; Thu, 25 Jul 2002 10:53:51 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:45064 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S315427AbSGYOxu>; Thu, 25 Jul 2002 10:53:50 -0400
Message-Id: <200207251455.g6PEtvbA048548@aslan.scsiguy.com>
To: Jens Axboe <axboe@suse.de>
cc: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>,
       linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] aic7xxx driver doesn't release region 
In-Reply-To: Your message of "Thu, 25 Jul 2002 15:21:18 +0200."
             <20020725132118.GB8761@suse.de> 
Date: Thu, 25 Jul 2002 08:55:57 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I don't recall when exactly this was fixed in the aic7xxx driver,
>> but probably 6.2.5 or so.  The 2.5.X kernel must not be using
>> a recent version of the driver.  Marcelo's tree has 6.2.8
>
>You make it sounds as if someone would be updating it for you. The
>version that is in 2.5 is the version that you last updated it to, end
>of story.

You make it sound like I have ever done any developement for 2.5.  I
haven't.  Someone else did the port of the aic7xxx to 2.5.  End of
story. 8-)

Unfortunately, I haven't had any spare time to play with 2.5.  I have
faithfully maintained the 2.4 driver and will look at 2.5 once the
time to do so presents itself.

--
Justin
