Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264122AbRFROyn>; Mon, 18 Jun 2001 10:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264128AbRFROyd>; Mon, 18 Jun 2001 10:54:33 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:56587 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264122AbRFROyV>; Mon, 18 Jun 2001 10:54:21 -0400
Date: Mon, 18 Jun 2001 11:54:09 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Andrea Arcangeli <andrea@suse.de>
Cc: German Gomez Garcia <german@piraos.com>,
        Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange behaviour of swap under 2.4.5-ac15
In-Reply-To: <20010618155605.D13836@athlon.random>
Message-ID: <Pine.LNX.4.33.0106181153440.32426-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001, Andrea Arcangeli wrote:

> > which is now a lot closer to being balanced. It's not a bug,
>
> wrong, that was a core showstopper bug and it renders any
> machine with a zone empty unusable. (it has nothing to do with
> beauty or stats)

YOUR PATCH fixes a real bug, true.  But that wasn't
what German was complaining about ;)

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

