Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129692AbRAUUTh>; Sun, 21 Jan 2001 15:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129729AbRAUUT1>; Sun, 21 Jan 2001 15:19:27 -0500
Received: from tweetie.comstar.net ([130.205.120.2]:63122 "EHLO
	tweetie.comstar.net") by vger.kernel.org with ESMTP
	id <S129692AbRAUUTQ>; Sun, 21 Jan 2001 15:19:16 -0500
Date: Sun, 21 Jan 2001 15:17:50 -0500 (EST)
From: Gregory McLean <gregm@comstar.net>
To: Joel Franco Guzmán <joel@gds-corp.com>
cc: <sailer@ife.ee.ethz.ch>, <hb9jnx@hb9w.che.eu.redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: 128M memory OK, but with 192M sound card es1391 trouble
In-Reply-To: <Pine.LNX.4.30.0101172037310.1309-100000@thor.gds-corp.com>
Message-ID: <Pine.LNX.4.30.0101211516090.25241-100000@tweetie.comstar.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Joel Franco Guzmán wrote:

[snip]
>
> the problem: The sound card generates a toc.. toc.. toc .. toc...while
> playing a sound using the DSP of the soundcard. Two "tocs"/sec
> aproxiumadetely.
>
Just for giggles, turn down the LINE-IN volume (or mute it) See if the
noise goes away.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
