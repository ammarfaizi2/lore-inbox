Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313057AbSEEPYb>; Sun, 5 May 2002 11:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313041AbSEEPYb>; Sun, 5 May 2002 11:24:31 -0400
Received: from [212.159.14.227] ([212.159.14.227]:54451 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S313026AbSEEPYa>; Sun, 5 May 2002 11:24:30 -0400
Date: Sun, 5 May 2002 16:23:33 +0100
From: "J.P. Morris" <jpm@it-he.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.x keyboard oddities
Message-Id: <20020505162333.5f5415c4.jpm@it-he.org>
In-Reply-To: <20020505124704.GC4990@louise.pinerecords.com>
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 May 2002 14:47:04 +0200
Tomas Szepe <szepe@pinerecords.com> wrote:

> > [J.P. Morris <jpm@it-he.org>]
> >
> > The system appears to have come up completely now, except for the
> > keyboard which is totally frozen throughout the entire boot process.
> 
> 1) Try booting with 'acpi=off'. It's broken for a number of systems
> (does precisely what you've described) and no official update is
> available as of yet. Alternatively, you can try to apply the most
> recent ACPI patch from [1].

Thanks, turning off ACPI fixes it.


-- 
JP Morris - aka DOUG the Eagle (Dragon) -=UDIC=-  doug@it-he.org
Fun things to do with the Ultima games            http://www.it-he.org
Developing a U6/U7 clone                          http://ire.it-he.org
d+++ e+ N+ T++ Om U1234!56!7'!S'!8!9!KA u++ uC+++ uF+++ uG---- uLB----
uA--- nC+ nR---- nH+++ nP++ nI nPT nS nT wM- wC- y a(YEAR - 1976)
