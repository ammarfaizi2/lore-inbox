Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313795AbSDPRwp>; Tue, 16 Apr 2002 13:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313796AbSDPRwo>; Tue, 16 Apr 2002 13:52:44 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:36814 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S313795AbSDPRwa>;
	Tue, 16 Apr 2002 13:52:30 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15548.25819.487824.338429@napali.hpl.hp.com>
Date: Tue, 16 Apr 2002 10:52:27 -0700
To: Davide Libenzi <davidel@xmailserver.org>
Cc: davidm@hpl.hp.com, Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <Pine.LNX.4.44.0204161013050.1460-100000@blue1.dev.mcafeelabs.com>
X-Mailer: VM 7.03 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 16 Apr 2002 10:18:18 -0700 (PDT), Davide Libenzi <davidel@xmailserver.org> said:

  Davide> i still have pieces of paper on my desk about tests done on
  Davide> my dual piii where by hacking HZ to 1000 the kernel build
  Davide> time went from an average of 2min:30sec to an average
  Davide> 2min:43sec. that is pretty close to 10%

Did you keep the timeslice roughly constant?

	--david
