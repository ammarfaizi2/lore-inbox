Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262354AbSJ0LJN>; Sun, 27 Oct 2002 06:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbSJ0LJN>; Sun, 27 Oct 2002 06:09:13 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:17384 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S262354AbSJ0LJN>; Sun, 27 Oct 2002 06:09:13 -0500
Date: Sun, 27 Oct 2002 06:15:31 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.44uc1 (MMU-less support)
Message-ID: <20021027111531.GA20475@gnu.org>
References: <fa.fd5mvtv.9gon33@ifi.uio.no> <87iszosf2g.fsf@tc-1-100.kawasaki.gol.ne.jp> <20021027074809.GA985@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021027074809.GA985@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
Blat: Foop
From: Miles Bader <miles@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 08:48:09AM +0100, Sam Ravnborg wrote:
> Well, most arch Makefiles could use some cleaning up - also with respect
> to the construct above.  My point was that there is no need to list
> prerequisites as several rules when they can be combined as one.

Well, sure.  I'm just trying to say that this shouldn't be considered a
problem with Greg's patch.  Since he's aiming for inclusion, I think a bit of
conservatism is a good thing...  :-)

-Miles
-- 
P.S.  All information contained in the above letter is false,
      for reasons of military security.
