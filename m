Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263288AbRFLU7j>; Tue, 12 Jun 2001 16:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263294AbRFLU7a>; Tue, 12 Jun 2001 16:59:30 -0400
Received: from web3505.mail.yahoo.com ([216.115.111.72]:61455 "HELO
	web3505.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263288AbRFLU7I>; Tue, 12 Jun 2001 16:59:08 -0400
Message-ID: <20010612205848.20245.qmail@web3505.mail.yahoo.com>
Date: Tue, 12 Jun 2001 21:58:48 +0100 (BST)
From: =?iso-8859-1?q?Mich=E8l=20Alexandre=20Salim?= 
	<salimma1@yahoo.co.uk>
Subject: Re: Clock drift on Transmeta Crusoe
To: Jonathan Morton <chromi@cyberspace.org>, Pavel Machek <pavel@suse.cz>,
        linux-kernel@vger.kernel.org
In-Reply-To: <l03130300b74b9ddb0369@[192.168.239.105]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jonathan Morton <chromi@cyberspace.org> wrote: >
>> clock drift of a few minutes per day.
> 
> That's about 0.1%.  It may be relatively large
> compared to tolerances of
> hardware clocks, but it's realistically tiny.  It
> certainly compares
> favourably with mkLinux on my PowerBook 5300, which
> usually drifts by
> several hours per day regardless of actual load.
Several hours a day, gosh...

Thanks for the responses, is it a common problem in
notebooks then? Did not notice this on desktops
before, anyway trying to adjust for the drift using
adjtimex now.

Regards,

Michel

____________________________________________________________
Do You Yahoo!?
Get your free @yahoo.co.uk address at http://mail.yahoo.co.uk
or your free @yahoo.ie address at http://mail.yahoo.ie
