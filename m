Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273983AbRJKIuM>; Thu, 11 Oct 2001 04:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273996AbRJKIuD>; Thu, 11 Oct 2001 04:50:03 -0400
Received: from taifun.devconsult.de ([212.15.193.29]:7181 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S273983AbRJKItt>; Thu, 11 Oct 2001 04:49:49 -0400
Date: Thu, 11 Oct 2001 10:50:16 +0200
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Concerned Programmer <tkhoadfdsaf@hotmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Alexander Viro <viro@math.psu.edu>, Keith Owens <kaos@ocs.com.au>,
        "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Tainted Modules Help Notices
Message-ID: <20011011105016.C28145@devcon.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Concerned Programmer <tkhoadfdsaf@hotmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Alexander Viro <viro@math.psu.edu>, Keith Owens <kaos@ocs.com.au>,
	"Morgan Collins [Ax0n]" <sirmorcant@morcant.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <OE64YU5ts1Tjkw1BzCf0000708c@hotmail.com> <E15rQjC-0000m2-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15rQjC-0000m2-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Oct 10, 2001 at 10:17:22PM +0100
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 10:17:22PM +0100, Alan Cox wrote:
> 
> Hardly. Its there to handle maintainability issues. Right now its got some 
> glitches - and the BSD one is a glitch we need to sort out. Clearly BSD
> stuff where the source is in the kernel is not harming anyones ability to
> deubg.

What about simply adding "BSD (included in kernel)" as a possible
"untainted" MODULE_LICENSE()?

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
