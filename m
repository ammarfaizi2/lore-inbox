Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132101AbRCYQgV>; Sun, 25 Mar 2001 11:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132108AbRCYQgK>; Sun, 25 Mar 2001 11:36:10 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:16438 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S132101AbRCYQgE>;
	Sun, 25 Mar 2001 11:36:04 -0500
Message-ID: <20010325183522.A6759@win.tue.nl>
Date: Sun, 25 Mar 2001 18:35:22 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Stephen Clouse <stephenc@theiqgroup.com>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010323174319.A6487@win.tue.nl> <Pine.LNX.4.21.0103240257010.1863-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0103240257010.1863-100000@imladris.rielhome.conectiva>; from Rik van Riel on Sat, Mar 24, 2001 at 02:57:27AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2001 at 02:57:27AM -0300, Rik van Riel wrote:
> On Fri, 23 Mar 2001, Guest section DW wrote:
> > On Fri, Mar 23, 2001 at 11:56:23AM -0300, Rik van Riel wrote:
> > > On Fri, 23 Mar 2001, Martin Dalecki wrote:
> > 
> > > > > Feel free to write better-working code.
> > > > 
> > > > I don't get paid for it and I'm not idling through my days...
> > > 
> > >   <similar response from Andries>
> > 
> > No lies please.
> 
> You mean that you ARE willing to implement what you've been
> arguing for?

There had not been any such response by me -
thus you should not ascribe to me such a response.

Concerning overcommit: people tell me that Eduardo Horvath
in his patch submitted to l-k on 2000-03-31 already solved
the problem (entirely or to a large extent).

: This patch will prevent the linux kernel from allowing VM overcommit.

I have not yet read the code.

Andries
