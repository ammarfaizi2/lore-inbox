Return-Path: <linux-kernel-owner+w=401wt.eu-S937382AbWLKR6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937382AbWLKR6X (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 12:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937387AbWLKR6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 12:58:23 -0500
Received: from web57812.mail.re3.yahoo.com ([68.142.236.90]:38014 "HELO
	web57812.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S937382AbWLKR6V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 12:58:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=R9EOLRWdFhK/cUacnLOldi0xME1HjB6oPBv/p0pCie/YoPDFXT+XdzpvPBG9JNEbBiz78DVNKqU9buV6ZyMMIY8FVvjVdjYmXggIDFuTRCD74WiVDPA9zmy1TixRXtgfRl+UIHyCVUZ/8NR5kYk469849H0BsAfTcz3wLKTrCp8=  ;
Message-ID: <20061211175817.7840.qmail@web57812.mail.re3.yahoo.com>
Date: Mon, 11 Dec 2006 09:58:17 -0800 (PST)
From: Rakhesh Sasidharan <rakheshster@yahoo.com>
Reply-To: Rakhesh Sasidharan <rakhesh@rakhesh.com>
Subject: Re: VCD not readable under 2.6.18
To: Alan <alan@lxorguk.ukuu.org.uk>, Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just dropping a note that I booted into single user mode today and tried mounting the VCD -- and it worked! So I guess, yeah, the problem must be something to do with HAL etc. Some change to the kernel probably breaks something in HAL (just a guess) .......... whatever, am stuck now coz I can't play VCDs until this problem is fixed! Heh!

Rakhesh 

----- Original Message ----
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Rakhesh Sasidharan <rakhesh@rakhesh.com>; linux-kernel@vger.kernel.org
Sent: Sunday, December 10, 2006 4:50:32 AM
Subject: Re: VCD not readable under 2.6.18


> BUT TRY AGAIN" rather than a permanent error. Asking every 
> media-consious application to be rewritten is perhaps not the best 
> solution, either return another error, or return what application expect 
> (non-error but no data??)

Unfortunately nobody changed the behaviour just fixed bugs that were
hiding existing bad behaviour. Please take the polling mess up with the
HAL and KDE developers.

Alan


 
____________________________________________________________________________________
Yahoo! Music Unlimited
Access over 1 million songs.
http://music.yahoo.com/unlimited
