Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263347AbRFLVBt>; Tue, 12 Jun 2001 17:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbRFLVBj>; Tue, 12 Jun 2001 17:01:39 -0400
Received: from web3505.mail.yahoo.com ([216.115.111.72]:28177 "HELO
	web3505.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263347AbRFLVBV>; Tue, 12 Jun 2001 17:01:21 -0400
Message-ID: <20010612210048.20746.qmail@web3505.mail.yahoo.com>
Date: Tue, 12 Jun 2001 22:00:48 +0100 (BST)
From: =?iso-8859-1?q?Mich=E8l=20Alexandre=20Salim?= 
	<salimma1@yahoo.co.uk>
Subject: Re: Clock drift on Transmeta Crusoe
To: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20010611223357.A959@bug.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Pavel Machek <pavel@suse.cz> wrote:
> Let me guess: vesafb?
I am running vesafb, yes...

> If problem goes away when you stop using framebuffer
> (i.e. go X), then
> it is known. 
but the problem happens in X as well :)

> You are lucky. My machine is able to loose 2 minutes
> from every 3
> minutes.

Indeed :) Thanks, it seems like mine is just a normal
drift.

Regards,

Michel

____________________________________________________________
Do You Yahoo!?
Get your free @yahoo.co.uk address at http://mail.yahoo.co.uk
or your free @yahoo.ie address at http://mail.yahoo.ie
