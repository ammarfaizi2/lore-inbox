Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131003AbRAYUq4>; Thu, 25 Jan 2001 15:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136073AbRAYUps>; Thu, 25 Jan 2001 15:45:48 -0500
Received: from [63.95.13.242] ([63.95.13.242]:44622 "EHLO
	zso-powerapp-01.zeusinc.com") by vger.kernel.org with ESMTP
	id <S136072AbRAYUpa>; Thu, 25 Jan 2001 15:45:30 -0500
Message-ID: <009f01c0870f$a8c5ac00$1a040a0a@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Micah Gorrell" <angelcode@myrealbox.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <003401c0870c$3362e390$9b2f4189@angelw2k>
Subject: Re: eepro100 problems in 2.4.0
Date: Thu, 25 Jan 2001 15:44:47 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I have doing some testing with kernel 2.4 and I have had constant
problems
> with the eepro100 driver.  Under 2.2 it works perfectly but under 2.4 I am
> unable to use more than one card in a server and when I do use one card I
> get errors stating that eth0 reports no recources.  Has anyone else seen
> this kind of problem?

I had a similar problem with a server that had dual embedded eepro100
adapters however selecting the 'Enable Power Management (EXPERIMENTAL)'
option for the eepro100 seemed to make the problem go away.  I don't really
know why but it might be worth trying if it wasn't already selected.

Later,
Tom



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
