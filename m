Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276947AbRJQPeY>; Wed, 17 Oct 2001 11:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276933AbRJQPeO>; Wed, 17 Oct 2001 11:34:14 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:61458 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S276920AbRJQPd4>; Wed, 17 Oct 2001 11:33:56 -0400
Date: Wed, 17 Oct 2001 12:12:51 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Robert Cohen <robert.cohen@anu.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bench] New benchmark showing fileserver problem in 2.4.12
In-Reply-To: <3BCD8269.B4E003E5@anu.edu.au>
Message-ID: <Pine.LNX.4.21.0110171208560.11099-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Robert, 

I appreciated your report. Thanks.

The network issue is what I'm concerned with: the kernel core methods are
the _same_ with and without networking.

If you're able to reproduce the problem locally I'll try to track down the
thing. Three factors (involving network, which I know almost nothing
about) are too much for me right now :)

On Wed, 17 Oct 2001, Robert Cohen wrote:

> I have had a chance to do some more testing with the test program I
> posted yesterday. I have been able to try various combinations of
> parameters and variations of the programs.

