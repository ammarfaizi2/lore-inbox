Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286108AbRLZAyk>; Tue, 25 Dec 2001 19:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286111AbRLZAya>; Tue, 25 Dec 2001 19:54:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:46587 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S286108AbRLZAyY>;
	Tue, 25 Dec 2001 19:54:24 -0500
Date: Wed, 26 Dec 2001 01:53:27 +0100
From: Christian Ohm <chr.ohm@gmx.net>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file corruption in 2.4.16/17
Message-ID: <20011226005327.GA3970@moongate.thevoid.net>
In-Reply-To: <20011222220223.GA537@moongate.thevoid.net> <3C26F2AC.1050809@namesys.com> <20011225004459.GB3752@moongate.thevoid.net> <3C285384.3020302@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C285384.3020302@namesys.com>
User-Agent: Mutt/1.3.24i
Organization: theVoid
X-Operating-System: Linux moongate 2.4.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So if I understand right, Andre Hedrick thinks it might be whatever 
> driver is in the 2.4.16 kernel?

if it is, it seems to be the way reiserfs uses it, and not a general issue
of the driver itself. i don't really think this is a hardware problem,
unless anyone can give me a convincing reason why it should/could be.

> If you can reproduce it for 2.4.17 we will eagerly debug it.

i'll try, though i'm not really eager to get my files corrupted. so i think
i'll just copy some files from the old to the new drive and diff them to see
if they get corrupted with a plain 2.4.17 kernel. if they do, any ideas how
to track it down further?

bye
christian ohm
