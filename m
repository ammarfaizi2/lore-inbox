Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbSJZKqS>; Sat, 26 Oct 2002 06:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbSJZKqR>; Sat, 26 Oct 2002 06:46:17 -0400
Received: from users.linvision.com ([62.58.92.114]:9365 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S261908AbSJZKqR>; Sat, 26 Oct 2002 06:46:17 -0400
Date: Sat, 26 Oct 2002 12:52:30 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: bert hubert <ahu@ds9a.nl>, Latha B lingaiah <l_lingaiah@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: TCP  DELAY
Message-ID: <20021026125230.E16359@bitwizard.nl>
References: <20021021065600.3738.qmail@web12806.mail.yahoo.com> <20021021065839.GA6108@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021021065839.GA6108@outpost.ds9a.nl>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 08:58:39AM +0200, bert hubert wrote:
> On Sun, Oct 20, 2002 at 11:56:00PM -0700, Latha B lingaiah wrote:
> > Hi,
> > 
> > While transfering a 42MB file, there seem to be a TCP
> > delay between the kernels 2.4.7 and 2.4.18.
> 
> Don't do such short measurements, 4.5 seconds is no way to do statistics.
> TCP/IP does not start out at full speed but takes some time to find the
> right speed.

If all you do is repeatedly transfer small files of only 42Mb, the
difference of 18% between 3.7 and 4.4 seconds is quite measureable. 

But you should measure the difference more than once, but I suspect
that this was indeed done.....

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
