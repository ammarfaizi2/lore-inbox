Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131019AbRCFQ7b>; Tue, 6 Mar 2001 11:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131020AbRCFQ7M>; Tue, 6 Mar 2001 11:59:12 -0500
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:48521 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S131019AbRCFQ7J>; Tue, 6 Mar 2001 11:59:09 -0500
Message-ID: <3AA517DB.A5963C9F@alumni.caltech.edu>
Date: Tue, 06 Mar 2001 09:01:15 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Reply-To: dank@alumni.caltech.edu
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jorge_ortiz@hp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Process vs. Threads
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jorge_ortiz@hp.com wrote:
> I have been trying to differenciate threads and process in Linux. As 
> I am sure you already know, other OS, namely HPUX, implement threads 
> in a different way. ...
> Of course, I am talking about kernel 2.2.x, but AFAIK this has not 
> changed in the new kernels.

It's starting to change a bit; see the discussion following
  http://boudicca.tux.org/hypermail/linux-kernel/2000week36/0903.html
  ("thread group comments").

Can someone summarize the state of the thread changes in 2.4?  
A lot seemed to happen, but from what I gather, nothing user-visible yet.

- Dan
