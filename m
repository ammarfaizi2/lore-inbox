Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269815AbRIHOuw>; Sat, 8 Sep 2001 10:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269829AbRIHOum>; Sat, 8 Sep 2001 10:50:42 -0400
Received: from web20309.mail.yahoo.com ([216.136.226.90]:19983 "HELO
	web20309.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269815AbRIHOua>; Sat, 8 Sep 2001 10:50:30 -0400
Message-ID: <20010908145050.85837.qmail@web20309.mail.yahoo.com>
Date: Sat, 8 Sep 2001 07:50:50 -0700 (PDT)
From: Ethan Baldridge <marginal_warfare@yahoo.com>
Subject: AGPgart broken in 2.4.9-ac9 for Via KT266
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It detects the AGP chipset fine, but when X starts,
it displays garbage and hard locks the console.

I know it's not an issue with the Radeon DRI driver,
as I compiled the radeon.o module directly out of the
same XFree86 CVS download I was using before I
upgraded my motherboard.

On load the agpgart module does give an odd message:
agpgart: unable to get minor: 175

I checked /dev/agpgart, and it is definitely minor
175.
What does it mean it can't get that minor?

Please CC any responses to me, as I am not subscribed
to the list.

Thank you very much!

Ethan Baldridge

__________________________________________________
Do You Yahoo!?
Get email alerts & NEW webcam video instant messaging with Yahoo! Messenger
http://im.yahoo.com
