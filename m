Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317779AbSHHRhR>; Thu, 8 Aug 2002 13:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317735AbSHHRgX>; Thu, 8 Aug 2002 13:36:23 -0400
Received: from zok.SGI.COM ([204.94.215.101]:24274 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S317701AbSHHRf6>;
	Thu, 8 Aug 2002 13:35:58 -0400
Date: Thu, 8 Aug 2002 10:39:33 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, jmacd@namesys.com, phillips@arcor.de,
       rml@tech9.net
Subject: Re: [PATCH] lock assertion macros for 2.5.30
Message-ID: <20020808173933.GA29474@sgi.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org, jmacd@namesys.com, phillips@arcor.de,
	rml@tech9.net
References: <20020808172335.GA29509@sgi.com> <Pine.LNX.4.44L.0208081435400.2589-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0208081435400.2589-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 02:36:46PM -0300, Rik van Riel wrote:
> Looks fine to me, but I'm not a SCSI guy so you'll have to
> ask them about integrating the patch ;)

Oh, I meant that I removed those changes _from my patch_.  Now they're
confined to x86 and ia64 header files and some generic files.  I'm not
sure who to send it to now (Linus?).

> The other issues you raised are probably best done in
> separate patches.

Ok, thanks a lot for the feedback.

Jesse
