Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbRLFQvL>; Thu, 6 Dec 2001 11:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285169AbRLFQvD>; Thu, 6 Dec 2001 11:51:03 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:58893 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S285051AbRLFQu4>; Thu, 6 Dec 2001 11:50:56 -0500
Date: Thu, 6 Dec 2001 14:49:56 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Rob Landley <landley@trommello.org>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, <linux-kernel@vger.kernel.org>,
        <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
In-Reply-To: <20011206001558.OQCD485.femail3.sdc1.sfba.home.com@there>
Message-ID: <Pine.LNX.4.33L.0112061447560.1282-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Rob Landley wrote:

> 3) The fact Linus was cc'd on this before I trimmed it suggests to me
> that people are still wishfully thinking that the battle they lost
> before the linux-kernel summit would just magically re-open at the
> last minute.  It's not about the fact that reiserfs, ext3, and a new
> VM subsystem went into 2.4 but THIS is way too much,

IMHO it's not acceptable that people upgrading from one 2.4
kernel to the next will have to install Python 2 on their
machine. Security bugs are and will be discovered, you cannot
make it impossible for people to do security upgrades.

Reiserfs, ext3 and the new VM have never changed the build
requirements for people and haven't made it impossible for
people to upgrade to a new kernel.

> It's insidious, isn't it?

Yes, I agree the method you're using to smuggle CML2 into
a stable kernel is insidious. Please stop it.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

