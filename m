Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290225AbSAOSH1>; Tue, 15 Jan 2002 13:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290229AbSAOSHT>; Tue, 15 Jan 2002 13:07:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25615 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290225AbSAOSHF>; Tue, 15 Jan 2002 13:07:05 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Why not "attach" patches?
Date: Tue, 15 Jan 2002 18:04:40 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a21qvo$375$1@penguin.transmeta.com>
In-Reply-To: <005901c19dec$59a89e30$0201a8c0@HOMER> <3C446C77.3000806@evision-ventures.com>
X-Trace: palladium.transmeta.com 1011117996 4726 127.0.0.1 (15 Jan 2002 18:06:36 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 15 Jan 2002 18:06:36 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C446C77.3000806@evision-ventures.com>,
Martin Dalecki  <dalecki@evision-ventures.com> wrote:
>
>Don't worry - nothign prevents proper attached patches from beeing 
>applied - the FAQ is only a bit zealous on this ;-)

Wrong.

If I get a patch in an attachment (other than a "Text/PLAIN" type
attachment with no mangling and that pretty much all mail readers and
all tools will see as a normal body), I simply WILL NOT apply it unless
I have strong reason to. I usually wont even bother looking at it,
unless I expected something special from the sender.

Really. Don't send patches as attachments. 

		Linus
