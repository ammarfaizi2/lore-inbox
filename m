Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273635AbRIQOmL>; Mon, 17 Sep 2001 10:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273637AbRIQOmB>; Mon, 17 Sep 2001 10:42:01 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:7186 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273635AbRIQOlt>; Mon, 17 Sep 2001 10:41:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: broken VM in 2.4.10-pre9
Date: Mon, 17 Sep 2001 16:49:16 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0109170936010.2990-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0109170936010.2990-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010917144206Z16393-2758+146@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 17, 2001 02:41 pm, Rik van Riel wrote:
> > On the other hand, Matt Dillon, the reigning champion of
> > virtual memory managment, was quite firm in stating that we should
> > drop the current virtually scanning strategy in favor of 100%
> > physical scanning as BSD uses, relying on reverse mapping.
> >
> >    http://mail.nl.linux.org/linux-mm/2000-05/msg00419.html
> >    (Matt Dillon holds forth on the design of BSD's memory manager)
> 
> His claims are backed up by FreeBSD's VM performance,
> so I'm inclined to believe them. If you think you can
> come up with something better, I'll believe you when
> you show it...

Rik, read the post, I'm supporting you.  Please don't be so paranoid ;-)

--
Daniel
