Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268940AbRG0Tb2>; Fri, 27 Jul 2001 15:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268941AbRG0TbS>; Fri, 27 Jul 2001 15:31:18 -0400
Received: from cs159246.pp.htv.fi ([213.243.159.246]:45222 "EHLO
	porkkala.cs159246.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S268940AbRG0TbE>; Fri, 27 Jul 2001 15:31:04 -0400
Message-ID: <3B61C16F.AD4A1B24@pp.htv.fi>
Date: Fri, 27 Jul 2001 22:30:55 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: bvermeul@devel.blackstar.nl
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33.0107272037380.16051-100000@devel.blackstar.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

bvermeul@devel.blackstar.nl wrote:
> 
> Possibly. We're talking 130 kByte in total. The above is the reason why
> I don't like using reiserfs on my development system. My files get
> completely garbled, with the data randomly distributed over the files 

How about using notail -option?

 - Jussi

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
