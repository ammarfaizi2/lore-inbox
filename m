Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267378AbRGLALX>; Wed, 11 Jul 2001 20:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267379AbRGLALD>; Wed, 11 Jul 2001 20:11:03 -0400
Received: from web14402.mail.yahoo.com ([216.136.174.59]:14350 "HELO
	web14402.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267378AbRGLAK5>; Wed, 11 Jul 2001 20:10:57 -0400
Message-ID: <20010712001058.9730.qmail@web14402.mail.yahoo.com>
Date: Wed, 11 Jul 2001 17:10:58 -0700 (PDT)
From: Rajeev Bector <rajeev_bector@yahoo.com>
Subject: Re: new IPC mechanism ideas
To: linux-kernel@vger.kernel.org
Cc: hpa@zytor.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your comment, Peter.
The problem with using a "driver"
process is that now you need
another mechanism to communicate
with that driver - either
message queues or shared
memory or something.

Thanks,
Rajeev


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
