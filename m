Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288194AbSAHRhb>; Tue, 8 Jan 2002 12:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288192AbSAHRhW>; Tue, 8 Jan 2002 12:37:22 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:50570
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288194AbSAHRhL>; Tue, 8 Jan 2002 12:37:11 -0500
Date: Tue, 8 Jan 2002 12:22:06 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Missing entries in Configuure.help)
Message-ID: <20020108122206.B24186@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Greg KH <greg@kroah.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020106210233.A30319@thyrsus.com> <20020107155654.GA6810@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020107155654.GA6810@kroah.com>; from greg@kroah.com on Mon, Jan 07, 2002 at 07:56:54AM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com>:
> On Sun, Jan 06, 2002 at 09:02:33PM -0500, Eric S. Raymond wrote:
> > The following symbols (mostly ARM port stuff) are missing enntries in
> > Configure.help.  Please contribute help entries if you can.
> 
> You might want to state which kernel version you are referring to.
> 
> > USB_EHCI_HCD
> > USB_SERIAL_IPAQ
> > USB_SERIAL_KLSI
> > USB_STV680
> > USB_VICAM
> 
> All of these are present in 2.5.2-pre7, 2 kernel versions ago :)

I've got entries for three of these now.  I'll post a revised list shortly.

I'm keeping Configure.help up to date with respect to both the 2.5
and 2.4 branches.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

What is a magician but a practicing theorist?
	-- Obi-Wan Kenobi, 'Return of the Jedi'
