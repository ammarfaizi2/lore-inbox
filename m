Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265778AbRFXWsm>; Sun, 24 Jun 2001 18:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265779AbRFXWsc>; Sun, 24 Jun 2001 18:48:32 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:8208 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265778AbRFXWsT>; Sun, 24 Jun 2001 18:48:19 -0400
Date: Sun, 24 Jun 2001 19:48:13 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "Alexander V. Bilichenko" <dmor@7ka.mipt.ru>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: GCC3.0 Produce REALLY slower code!
In-Reply-To: <001301c0fcff$47c05160$d55355c2@microsoft>
Message-ID: <Pine.LNX.4.33L.0106241947230.23112-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2001, Alexander V. Bilichenko wrote:

> Some tests that I have recently check out. kernel compiled with
> 3.0 (2.4.5) function call: 1000000 iteration. 3% slower than
> 2.95. test example - hash table add/remove - 4% slower (compiled
> both with -O2 -march=i686).

> Why have this version been released?

It would be better to ask that to the GCC people, but I
suspect it was released because it was (almost) stable
and the only way to do the last small tweaks to the code
would be to have it tested in the field ?

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

