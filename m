Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317404AbSIHRfs>; Sun, 8 Sep 2002 13:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318107AbSIHRfs>; Sun, 8 Sep 2002 13:35:48 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:29446 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S317404AbSIHRfr>; Sun, 8 Sep 2002 13:35:47 -0400
Date: Mon, 9 Sep 2002 03:40:22 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Performance issue in 2.5.32+
In-Reply-To: <200209081545.g88FjQZ10714@penguin.transmeta.com>
Message-ID: <Mutt.LNX.4.44.0209090326100.21359-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Sep 2002, Linus Torvalds wrote:

> That "something else" may be some process that is constantly running one
> one CPU or something.
> 
> Maybe something got confused by the kernel change, and is now getting
> stuck in the background? 

Not as far as I can tell.  The system is RH 7.3 with errata, and I've run
the tests again after shutting down everything except console login with
no change.  No processes seem to be running abnormally.

I guess it could be an existing hardware problem which has been triggered 
by some innocuous change.


- James
-- 
James Morris
<jmorris@intercode.com.au>


