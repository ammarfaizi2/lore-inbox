Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265512AbRFVUzO>; Fri, 22 Jun 2001 16:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265511AbRFVUzE>; Fri, 22 Jun 2001 16:55:04 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:34057 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265510AbRFVUyu>; Fri, 22 Jun 2001 16:54:50 -0400
Date: Fri, 22 Jun 2001 17:54:20 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Russell King <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <kbuild-devel@lists.sourceforge.net>
Subject: Re: Maintainers master list?
In-Reply-To: <20010622160002.B16285@thyrsus.com>
Message-ID: <Pine.LNX.4.33L.0106221753140.4442-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2001, Eric S. Raymond wrote:

> I have proposed that the MAINTAINERS file should be replaced by
> metadata markup in the kernel sources themselves, distributed so that
> it will naturally be kept up to date by the people named in it and
> mechanically gathered into a generated MAINTAINERS at make dep time.

Look, when somebody stops maintaining something, they'll
stop sending patches. When this happens it's only natural
that the information you want to use to generate the
MAINTAINERS file is also out of date.

I fail to see how your idea would solve anything.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

