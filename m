Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265341AbRF0SOD>; Wed, 27 Jun 2001 14:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbRF0SNx>; Wed, 27 Jun 2001 14:13:53 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:37640 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265341AbRF0SNu>; Wed, 27 Jun 2001 14:13:50 -0400
Date: Wed, 27 Jun 2001 15:13:43 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <3B399EF8.9BA76FA2@TeraPort.de>
Message-ID: <Pine.LNX.4.33L.0106271512570.23373-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2001, Martin Knoblauch wrote:

>  I do not care much whether the cache is using 99% of the systems memory
> or 50%. As long as there is free memory, using it for cache is great. I
> care a lot if the cache takes down interactivity, because it pushes out
> processes that it thinks idle, but that I need in 5 seconds. The caches
> pressure against processes

Too bad that processes are in general cached INSIDE the cache.

You'll have to write a new balancing story now ;)

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

