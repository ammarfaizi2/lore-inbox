Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270220AbRHMOUJ>; Mon, 13 Aug 2001 10:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270223AbRHMOTu>; Mon, 13 Aug 2001 10:19:50 -0400
Received: from femail42.sdc1.sfba.home.com ([24.254.60.36]:57761 "EHLO
	femail42.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S270220AbRHMOTs>; Mon, 13 Aug 2001 10:19:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: linux-kernel@vger.kernel.org
Subject: via82cxxx_audio driver bug?
Date: Mon, 13 Aug 2001 07:19:42 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01081307194201.00276@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(my apologies if this gets seen as a little offtopic, I felt this was the 
best place to get results from people who knew what was going on with 
drivers)
My writeup on the bug when I belived it was definitely an XMMS bug is 
avalible here:
http://bugs.xmms.org/show_bug.cgi?id=115
you'll need to scroll down to see details on what I isolated it to

I just sent email to the maintainer of the via82cxxx_audio driver 
regarding this bug, hopefully I'll hear back from him soon, but I'd also 
like to hear from anyone else who has used and/or hacked at this driver, 
and if they've seen XMMS or other audio applications with access to 
/dev/mixer have strange, temporarily lockups when not in root/realtime 
priority. I've yet to be able to test this with other audio applications 
besides XMMS.

Thanks.
