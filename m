Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311614AbSCXRqD>; Sun, 24 Mar 2002 12:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311615AbSCXRpw>; Sun, 24 Mar 2002 12:45:52 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:50705 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S311614AbSCXRpr>;
	Sun, 24 Mar 2002 12:45:47 -0500
Date: Sun, 24 Mar 2002 14:45:29 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, andreas <andihartmann@freenet.de>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
In-Reply-To: <Pine.LNX.4.30.0203241757520.30437-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.44L.0203241444560.18660-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2002, Roy Sigurd Karlsbakk wrote:

> Would it hard to do some memory allocation statistics, so if some
> process at one point (as rsync did) goes crazy eating all memory, that
> would be detected?

No.  What I doubt however is whether it would be worth it,
since most machines never run OOM.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

