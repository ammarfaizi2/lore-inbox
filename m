Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276151AbRJCMj5>; Wed, 3 Oct 2001 08:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276153AbRJCMjq>; Wed, 3 Oct 2001 08:39:46 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:19723 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S276151AbRJCMj3>;
	Wed, 3 Oct 2001 08:39:29 -0400
Date: Wed, 3 Oct 2001 09:39:39 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "sebastien.cabaniols" <sebastien.cabaniols@laposte.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [POT] Which journalised filesystem ? 
In-Reply-To: <GKMPCZ$IZh2dKhbICnp0WDXKHB6iO7OKoHwqOxmqj9XfriOC7PjHiIDA6bHi6xrImT@laposte.net>
Message-ID: <Pine.LNX.4.33L.0110030938130.4835-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2001, sebastien.cabaniols wrote:

> With the availability of XFS,JFS,ext3 and ReiserFS I am a little lost
> and I don't know which one I should use for entreprise class servers.

Personally I like ext3 a lot.  I've been using it for almost a
year now and it has never given me trouble.  In the theoretical
case where it would give me trouble, I'd have the very well
tested e2fsck utility to rescue me (ext2 and ext3 have the same
on-disk layout).

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

