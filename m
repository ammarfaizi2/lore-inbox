Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSCRQNf>; Mon, 18 Mar 2002 11:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288071AbSCRQNZ>; Mon, 18 Mar 2002 11:13:25 -0500
Received: from air-2.osdl.org ([65.201.151.6]:56850 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S287817AbSCRQNP>;
	Mon, 18 Mar 2002 11:13:15 -0500
Date: Mon, 18 Mar 2002 08:12:48 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Nayyer Tiger <tigerkhan_1@hotmail.com>
cc: <faheemullahkhan101@aol.com>, <zohair420@hotmail.com>,
        <danish4000@hotmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help
In-Reply-To: <F184dEXWU5oIvIZZwmo0000bd87@hotmail.com>
Message-ID: <Pine.LNX.4.33L2.0203180809120.2434-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002, Nayyer Tiger wrote:

| I see that in the very latest Configure.help version, 2.76, available at
| http:/www.tuxedo.org/~esr/cml2/
| Eric has decided to follow the following standard:
| IEC 60027-2, Second edition, 2000-11, Letter symbols to be used in
| electrical technology - Part 2: Telecommunications and electronics.
| and has changed all the abbreviations for Kilobyte (KB) to KiB, Megabyte
| (MB) to MiB, etc, etc.
|
| Now, granted that this is the "standard", should there be some discussion
| related to this
| change, or is everyone comfortable with this?  It certainly made me do a
| double take.

Either decision will be disliked.  I don't care for the new/standard
abbreviations, but I can get used to them, and I expect that most
people can.

Let's get over it and back to the good stuff.

~Randy

and who are all these anon. people you copied?!?

| Here is a snippet from the diff between versions 2.75 and 2.76 of
| Configure.help:
|
| @@ -344,8 +344,8 @@
|    If you are compiling a kernel which will never run on a machine with
|    more than 960 megabytes of total physical RAM, answer "off" here
|    (default choice and suitable for most users). This will result in a
| -  "3GB/1GB" split: 3GB are mapped so that each process sees a 3GB
| -  virtual memory space and the remaining part of the 4GB virtual memory
| +  "3GiB/1GiB" split: 3GiB are mapped so that each process sees a 3GiB
| +  virtual memory space and the remaining part of the 4GiB virtual memory
|    space is used by the kernel to permanently map as much physical memory
|    as possible.

