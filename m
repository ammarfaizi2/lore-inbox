Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRDCMrV>; Tue, 3 Apr 2001 08:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131461AbRDCMrK>; Tue, 3 Apr 2001 08:47:10 -0400
Received: from mail.veka.com ([213.68.6.130]:47825 "EHLO veka.com")
	by vger.kernel.org with ESMTP id <S131460AbRDCMq7>;
	Tue, 3 Apr 2001 08:46:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Frank Fiene <ffiene@veka.com>
Organization: Syntags GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS? How reliable is it? Is this the future?
Date: Tue, 3 Apr 2001 14:47:46 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <3AC9BE5A.DE079EE1@Synopsys.COM>
In-Reply-To: <3AC9BE5A.DE079EE1@Synopsys.COM>
MIME-Version: 1.0
Message-Id: <01040314474600.04589@fflaptop>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday,  3. April 2001 14:13, Harald Dunkel wrote:
> Hi folks,
>
> If I get the DVD stuff working, then I won't need NT anymore, i.e.
> I will have an empty disk.
>
> What is your impression about ReiserFS? Does it work? Is it stable
> enough for my daily work, or is it something to try out and watch
> carefully? Do you use ReiserFS for your boot partition?
>
> Or should I try ext3 instead?

I am using reiserfs since kernel 2.2.14 or so.
It runs on my IBM Thinkpad without complications with kernel 2.4.3.
Same with a Compaq Proliant Server, kernel 2.4.2-ac28, two PIII and a 
hardware raid controller. I heard about complications with nfs.
I cannot see any speed improvements (maybe there are some beacause of 
the tree structure) but the file system check after a crash is much 
faster than with ext2.
It would be nice, if there are any hackers from the xfs, ext3 or jfs 
development team with some comparisons.

ff
-- 
Frank Fiene, SYNTAGS GmbH, Im Defdahl 5-10, D-44141 Dortmund, Germany
Security, Cryptography, Networks, Software Development
http://www.syntags.de mailto:Frank.Fiene@syntags.de
