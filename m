Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267932AbRGWVwU>; Mon, 23 Jul 2001 17:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267931AbRGWVwM>; Mon, 23 Jul 2001 17:52:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:12305 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267932AbRGWVvi>; Mon, 23 Jul 2001 17:51:38 -0400
Date: Mon, 23 Jul 2001 18:51:36 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Larry McVoy <lm@bitmover.com>
Cc: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>,
        <linux-kernel@vger.kernel.org>, <linux-fsdev@vger.kernel.org>,
        <martizab@libertsurf.fr>, <rusty@rustcorp.com.au>
Subject: Re: Yet another linux filesytem: with version control
In-Reply-To: <20010723141751.W6820@work.bitmover.com>
Message-ID: <Pine.LNX.4.33L.0107231850200.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 23 Jul 2001, Larry McVoy wrote:

> b) Filesystem support for SCM is really a flawed approach.

Agreed.  I mean, how can you cleanly group changesets and
versions with a filesystem level "transparent" SCM ?

The goal of an SCM is to _manage_ versions and changesets,
if it doesn't do that we're back at CVS's "every file its
own versioning and to hell with manageability" ...

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

