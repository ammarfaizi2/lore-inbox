Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270989AbRH0Af6>; Sun, 26 Aug 2001 20:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271501AbRH0Afi>; Sun, 26 Aug 2001 20:35:38 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:54024 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S270989AbRH0Afc>; Sun, 26 Aug 2001 20:35:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Mon, 27 Aug 2001 02:42:25 +0200
X-Mailer: KMail [version 1.3.1]
Cc: <pcg@goof.com>, Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108262102050.5646-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108262102050.5646-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010827003545Z16325-32383+1532@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 27, 2001 02:02 am, Rik van Riel wrote:
> On Sun, 26 Aug 2001, Daniel Phillips wrote:
> 
> > > His kernel is running completely out of memory, with no
> > > swap space configured.
> >
> > No, he's streaming mp3's:
> 
> 1) these two are not exclusive
> 2) he clearly wrote that he was running out of memory,
>    though this was in a different email thread

So you're confident there's no problem here, even though all he's doing is a 
kernel build and playing mp3's with 24 meg available for the job.

--
Daniel
