Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132355AbQLHRIm>; Fri, 8 Dec 2000 12:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132347AbQLHRIc>; Fri, 8 Dec 2000 12:08:32 -0500
Received: from Cantor.suse.de ([194.112.123.193]:28171 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132355AbQLHRHi>;
	Fri, 8 Dec 2000 12:07:38 -0500
Date: Fri, 8 Dec 2000 17:37:09 +0100
From: Andi Kleen <ak@suse.de>
To: Fabien Ribes <fribes@capgemini.fr>
Cc: "David S. Miller" <davem@redhat.com>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Networking: RFC1122 and 1123 status for kernel 2.4
Message-ID: <20001208173709.A21397@gruyere.muc.suse.de>
In-Reply-To: <3A30F463.2EE04F4E@capgemini.fr> <200012081454.GAA02632@pizda.ninka.net> <20001208163154.A20038@gruyere.muc.suse.de> <3A310A12.446E2C4A@capgemini.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A310A12.446E2C4A@capgemini.fr>; from fribes@capgemini.fr on Fri, Dec 08, 2000 at 05:19:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 05:19:30PM +0100, Fabien Ribes wrote:
> Andi Kleen a écrit :
> > 
> > On Fri, Dec 08, 2000 at 06:54:28AM -0800, David S. Miller wrote:
> > >    Date:      Fri, 08 Dec 2000 15:46:59 +0100
> > >    From: Fabien Ribes <fribes@capgemini.fr>
> > >
> > >    Looking at Linux kernel sources, I've found RFC1122 status splitted in
> > >    each file. Is there a complete document showing RFC1122 status as a
> > >    whole for a given kernel version ?
> > >
> > > No, unfortunately nobody has the time to do this.
> > 
> > The RFC evaluation is also out of date and should be either redone or removed.
> 
> Indeed, what I need is some kind of paper insurance of interoperability
> ... so I believe grepping the sources for compliances will do the trick.

It would be nice if you could contribute a new evaluation in this case
(preferable as an external document for Documentation/) 

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
