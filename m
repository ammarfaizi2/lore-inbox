Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279642AbRKATxq>; Thu, 1 Nov 2001 14:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279644AbRKATxg>; Thu, 1 Nov 2001 14:53:36 -0500
Received: from adsl-209-233-33-110.dsl.snfc21.pacbell.net ([209.233.33.110]:49912
	"EHLO lorien.emufarm.org") by vger.kernel.org with ESMTP
	id <S279642AbRKATxU>; Thu, 1 Nov 2001 14:53:20 -0500
Date: Thu, 1 Nov 2001 11:53:19 -0800
From: Danek Duvall <duvall@emufarm.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Code from ~2.4.4 going into Solaris 9 Alpha?
Message-ID: <20011101115319.B2818@lorien.emufarm.org>
Mail-Followup-To: Danek Duvall <duvall@emufarm.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011101111508.A412@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20011101111508.A412@mikef-linux.matchmail.com>; from mfedyk@matchmail.com on Thu, Nov 01, 2001 at 11:15:08AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 11:15:08AM -0800, Mike Fedyk wrote:

> I just looked at http://perso.wanadoo.fr/levenez/unix/history.html, and
> noticed a line from linux over to solaris 9 alpha.
> 
> Does anyone know what code they copied, and if they're now making solaris
> GPL compatible?

That might simply be the inclusion of various "freeware" packages --
shells, gzip, apache, samba, and so forth, not necessarily kernel code.
All of those packages come with full source as well, so they should be
compliant with the GPL if that's how they happen to be licensed.

Of course, the line should probably be connected to Solaris 8, since
that's when most of these things started shipping with it.

Danek
