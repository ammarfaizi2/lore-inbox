Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315331AbSEGE2X>; Tue, 7 May 2002 00:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315332AbSEGE2W>; Tue, 7 May 2002 00:28:22 -0400
Received: from melancholia.rimspace.net ([210.23.138.19]:24332 "EHLO
	melancholia.danann.net") by vger.kernel.org with ESMTP
	id <S315331AbSEGE2V>; Tue, 7 May 2002 00:28:21 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Linux-2.5.14..
In-Reply-To: <Pine.LNX.4.44.0205060811360.2540-100000@home.transmeta.com>
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Tue, 07 May 2002 14:28:14 +1000
Message-ID: <87lmawintt.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.5 (bamboo,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2002, Linus Torvalds wrote:
> On Mon, 6 May 2002, Daniel Pittman wrote:
>>
>> From the look of the changelog at least a few of the file corruption
>> bugs with ext3, 2k block file systems and 2.5 have been fixed. Should
>> I expect this release to address the problems I was seeing?
> 
> "Expect" is too strong a word. I'd say "hope" - a number of truncate
> bugs were fixed, but whether that was what bit you, nobody knows.

Well, hope seems justified...

> I suspect the real answer is that we'd love for you to test things
> out, but that if it ends up being too painful to recover if the
> problems happen again, you probably shouldn't..

I did, and I failed to reproduce it working on a scratch disk. This was
a period of playing and I /hope/ that it's conclusive. I couldn't get
.12 to reliably fail, though, which is less inspiring.

I should be able to find some time in the next day or so to test it a
bit more on the scratch disk and then, if that works, I will update my
backups. :)

Still, it seems good so far.
        Daniel

-- 
Television is the ideal propaganda medium, a mendacious monster, not primarily
out of malice but from its amoral nature.
        -- Paul Johnson
