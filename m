Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317712AbSHHRer>; Thu, 8 Aug 2002 13:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317697AbSHHReE>; Thu, 8 Aug 2002 13:34:04 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:53519 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317698AbSHHRdQ>; Thu, 8 Aug 2002 13:33:16 -0400
Date: Thu, 8 Aug 2002 14:36:46 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Jesse Barnes <jbarnes@sgi.com>
Cc: linux-kernel@vger.kernel.org, <jmacd@namesys.com>, <phillips@arcor.de>,
       <rml@tech9.net>
Subject: Re: [PATCH] lock assertion macros for 2.5.30
In-Reply-To: <20020808172335.GA29509@sgi.com>
Message-ID: <Pine.LNX.4.44L.0208081435400.2589-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Jesse Barnes wrote:
> On Wed, Aug 07, 2002 at 07:19:21PM -0300, Rik van Riel wrote:
> > Looks good to me. Would be even better if you removed MUST_NOT_HOLD ;)
>
> Ok, here's yet another version.

Looks fine to me, but I'm not a SCSI guy so you'll have to
ask them about integrating the patch ;)

The other issues you raised are probably best done in
separate patches.

regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

