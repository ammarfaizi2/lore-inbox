Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271740AbRH0Oeb>; Mon, 27 Aug 2001 10:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271744AbRH0OeM>; Mon, 27 Aug 2001 10:34:12 -0400
Received: from jason.blazeconnect.net ([208.255.12.2]:13952 "HELO
	jason.blazeconnect.net") by vger.kernel.org with SMTP
	id <S271740AbRH0OeF>; Mon, 27 Aug 2001 10:34:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jason Straight <jason@blazeconnect.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.8-ac10,11,12 powersaving problems on Dell I8000
Date: Mon, 27 Aug 2001 10:29:36 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010827142937.6B48F5DF@jason.blazeconnect.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cc replies please - not a list member

All three of these have a problem with my Dell Inspiron 8000, something to do 
with powersaving features. I've turned off all powersaving in the BIOS, 
omitted all the powersaving from the kernel and still the machine turns 
itself off every so often with no warning - and no logs I can find. It 
doesn't like anything to do with powersaving features, if I close my display 
I re-open it to a locked up system.

2.4.8 unpatched works fine.



-- 
Jason Straight
BlazeConnect
President
Phone: 231-597-0376
Fax: 231-597-0393
