Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310210AbSCBARe>; Fri, 1 Mar 2002 19:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310209AbSCBARO>; Fri, 1 Mar 2002 19:17:14 -0500
Received: from geminia.tcd.ie ([134.226.16.161]:46923 "HELO mail.tcd.ie")
	by vger.kernel.org with SMTP id <S310205AbSCBARI>;
	Fri, 1 Mar 2002 19:17:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nick Murtagh <murtaghn@tcd.ie>
To: linux-kernel@vger.kernel.org
Subject: strange su behaviour
Date: Sat, 2 Mar 2002 00:17:06 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020302001706.9CCCBC7B@mail.tcd.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

When I exit from su in X, it takes about 10 seconds to return
to the command prompt. This doesn't happen in console mode.
I'm using Mandrake 8.1.

This didn't happen in 
  2.4.17-mjc1

But does happen in
  2.4.18-pre7-ac2
  2.4.19-pre2

I know this is not exactly a major problem or anything, 
but it's starting to bug me :) 

Anyone got any ideas?

Nick
