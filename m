Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130636AbRBAS2w>; Thu, 1 Feb 2001 13:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130291AbRBAS2l>; Thu, 1 Feb 2001 13:28:41 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:43530 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S131019AbRBAS2Y>; Thu, 1 Feb 2001 13:28:24 -0500
Date: Thu, 1 Feb 2001 10:27:48 -0800
To: List User <lists@chaven.com>
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: spelling of disc (disk) in /devfs
Message-ID: <20010201102748.B6959@ferret.phonewave.net>
In-Reply-To: <6lah7t4f685qo3igk679ocdo2obfhd9lvg@4ax.com> <030301c08be6$e494f480$160912ac@stcostlnds2zxj>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <030301c08be6$e494f480$160912ac@stcostlnds2zxj>; from lists@chaven.com on Wed, Jan 31, 2001 at 06:35:30PM -0600
From: idalton@ferret.phonewave.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 06:35:30PM -0600, List User wrote:
> If it's any consolation from (this American) I'm glad it's 'disc' (always
> thought that 'disk' was just for those marketing dweebs who couldn't spell
> right
> in the first place).

And in terms of casual usage, I've nearly always used 'disk' in
reference to media that can be mounted read-write, and 'disc' to media
that can only be mounted read-only.

More technically, 'disc' is a single media layer (usually a CD-ROM) and
'disk' is a removable media device with a protective casing.

Non-removable storage are generally refered to as 'drives'.

Yes, it's confusing.

-- Ferret

> ----- Original Message -----
> From: "Alan Chandler" <alan@chandlerfamily.org.uk>
> To: <linux-kernel@vger.kernel.org>
> Sent: Wednesday, January 31, 2001 18:19
> Subject: spelling of disc (disk) in /devfs
> 
> 
> > I accidentally built my 2.4.1 kernel with /devfs so had a interesting
> > few minutes looking round it to see what it was doing.
> >
> > The thing that struck me most was the spelling of disc with a 'c'.  As
> > an Englishman this is the correct spelling for me most of the time,
> > but I have come to accept "as a technical term" disk (as in American)
> > is the right name for these devices.
> >
> > I now find myself confused with the new approach.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
