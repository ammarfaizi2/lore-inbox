Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311841AbSEAMrj>; Wed, 1 May 2002 08:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311866AbSEAMri>; Wed, 1 May 2002 08:47:38 -0400
Received: from ulima.unil.ch ([130.223.144.143]:14465 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S311841AbSEAMri>;
	Wed, 1 May 2002 08:47:38 -0400
Date: Wed, 1 May 2002 14:47:37 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.12 compil error
Message-ID: <20020501124737.GA3452@ulima.unil.ch>
In-Reply-To: <20020501113505.GA17077@ulima.unil.ch> <Pine.LNX.4.21.0205011349100.23113-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 01:54:12PM +0200, Roman Zippel wrote:

> > make oldconfig
> > make dep bzImage modules
> > 
> > Isn't that supposed to be enough?
> 
> No, dependencies aren't automatically reloaded after "make dep", so the
> bzImage step used the old dependencies.

Oh, I see: I will change my way to compil knowing that, thanks you very
much for this info ;-))

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
