Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266431AbSL2QjG>; Sun, 29 Dec 2002 11:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266433AbSL2QjG>; Sun, 29 Dec 2002 11:39:06 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:1796 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266431AbSL2QjE>;
	Sun, 29 Dec 2002 11:39:04 -0500
Date: Sun, 29 Dec 2002 17:47:25 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Markus Pfeiffer <profmakx@profmakx.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Alpha port still maintained in 2.5
Message-ID: <20021229164725.GA1101@mars.ravnborg.org>
Mail-Followup-To: Markus Pfeiffer <profmakx@profmakx.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <200212291657.16326.profmakx@profmakx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212291657.16326.profmakx@profmakx.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 04:57:14PM +0100, Markus Pfeiffer wrote:
> Hi all!
> 
> I just tried compiling the current 2.5.53 kernel on alpha, and it's obviously 
> broken. Before I start tracking down everything, I'd like to know if somebody 
> already started working on the new module code and if patches exist, any 
> pointers etc. greatly appreciated

Richard Henderson is working with tgafb on alpha.
I'm looking into the architecture specific Makefiles in cooperation
with Richard.

I recall alpha patches from others as well, but do not recall anything
about module support.

	Sam
