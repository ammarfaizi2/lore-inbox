Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSEWMkJ>; Thu, 23 May 2002 08:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316637AbSEWMkI>; Thu, 23 May 2002 08:40:08 -0400
Received: from euston.inpharmatica.co.uk ([195.102.24.12]:64455 "EHLO
	sunsvr130.inpharmatica.co.uk") by vger.kernel.org with ESMTP
	id <S316615AbSEWMkG>; Thu, 23 May 2002 08:40:06 -0400
Message-ID: <3CECE320.7030908@purplet.demon.co.uk>
Date: Thu, 23 May 2002 13:40:00 +0100
From: Mike Jagdis <jaggy@purplet.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en, fr, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Have the 2.4 kernel memory management problems on large machines  been fixed?
In-Reply-To: <Pine.LNX.4.33.0205221352300.1531-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> And let's not _just_ blame oracle, maybe other uses can actually be found
> for this (eg XFree86 for UMA graphics cards etc might actually want to use
> something like this eventually).


Out here in bioinformatics land we have frequent games of "my data
set is bigger than your data set" and lots of the processing we do
is the sort of thing that could really benefit from big paged VM!

				Mike

