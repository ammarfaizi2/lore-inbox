Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288420AbSANAa2>; Sun, 13 Jan 2002 19:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288432AbSANAaT>; Sun, 13 Jan 2002 19:30:19 -0500
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:16808 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S288422AbSANAaQ>; Sun, 13 Jan 2002 19:30:16 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: yodaiken@fsmlabs.com
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 01:29:00 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020114003017Z288422-13996+5203@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 13. January 2002 17:56, yodaiken wrote:
> > He later said he did in fact build the same tree, from the same initial
> > condition, in single user mode, etc etc ... sounded like good testing
> > methodology to me.
>
> Really? You think that 
>                unpack a tar archive
>                make
>
> is a repeatable benchmark?

Do it tree times and send the geometric middle. Where's the problem?
Even with disk fragmentation. Maybe use an empty disk...

What about latencytest0.42-png?
We used it even before Ingo's O(1) existed.
Were can I find your latency test? Link?

-Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
