Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131354AbRACMPM>; Wed, 3 Jan 2001 07:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131368AbRACMOw>; Wed, 3 Jan 2001 07:14:52 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:22261 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131306AbRACMOp>; Wed, 3 Jan 2001 07:14:45 -0500
Date: Wed, 3 Jan 2001 09:43:54 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Sklar <sklarm@screwdecaf.cx>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM fixes + RSS limits 2.4.0-test13-pre5
In-Reply-To: <Pine.LNX.4.21.0012292007510.11006-100000@d13.com>
Message-ID: <Pine.LNX.4.21.0101030942430.1403-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2000, Mike Sklar wrote:

> If I wanted to adjust the rlim_cur value of a running
> processes, is there any sort of interface for that?

Hmmm, I don't think there is an interface to adjust the
per-process ulimit settings on-the-fly ...

Does anybody know if there's an interface for this ?

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
