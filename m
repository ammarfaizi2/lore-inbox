Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267449AbRGZAbl>; Wed, 25 Jul 2001 20:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267458AbRGZAbb>; Wed, 25 Jul 2001 20:31:31 -0400
Received: from [213.82.86.194] ([213.82.86.194]:57604 "EHLO fatamorgana.net")
	by vger.kernel.org with ESMTP id <S267449AbRGZAb1>;
	Wed, 25 Jul 2001 20:31:27 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roberto Arcomano <berto@fatamorgana.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Patch suggestion for proxy arp on shaper interface
Date: Thu, 26 Jul 2001 02:34:07 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01072602340703.01029@berto.casa.it>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Il 20:54, mercoledì 25 luglio 2001, hai scritto:
> Hello!
>
> > As I said in my first message, I tested it with 2.4.6 and it "appears" (I
> > tested it in a very little net) to work well
>
> The patch works right, I think. But it is so utterly ugly and its scope
> is so narrow, that I do think this is acceptable.
>
> Actually, you may use CBQ instead it does not create problems of this
> kind. Seems, scripts to setup it can be found in LRP. I can send it,
> but I am not sure that my copy is the newest.
>
> Alexey


Please send me script you was talking about.
I know that CBQ is a more recent (and I guess better) method to limit 
bandwidth, but I think also there are still many users of "shaper" device who 
would want to avoid proxy arp problems.

Thank you for all
Best Regards
Roberto Arcomano
