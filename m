Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284691AbRL3TzM>; Sun, 30 Dec 2001 14:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284687AbRL3TzD>; Sun, 30 Dec 2001 14:55:03 -0500
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:31991 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S284765AbRL3Tyu>; Sun, 30 Dec 2001 14:54:50 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
Date: Sun, 30 Dec 2001 20:54:52 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200112291907.LAA25639@messenger.mvista.com> <3C2EE5DC.6EB60E17@mvista.com>
In-Reply-To: <3C2EE5DC.6EB60E17@mvista.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011230195500Z284765-18284+9610@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 29. December 2001 21:00, you wrote:
>Dieter Nützel wrote:
> >
> > I ask because my MP3/Ogg-Vorbis hiccup during dbench isn't solved anyway.
> > Running 2.4.17 + preempt + lock-break + 10_vm-21 (AA).
> > Some wisdom?
>
> Please test this elevator patch.  I'll be putting it out more formally
> in a day or two.  Much more testing is needed yet, but for me, the
> time to read a 16 megabyte file whilst running dbench 160 falls from
> three minutes thirty seconds to seven seconds.  (This is a VM thing,
> not an elevator thing).

Andrew or anybody else,

can you please send me a copy directly?
The version I've extracted from the list is some what broken.
I am not on LKML 'cause it is to much traffic for such a poor little boy like 
me...;-)

Thanks,
	Dieter
