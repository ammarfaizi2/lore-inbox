Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132294AbQLHQxc>; Fri, 8 Dec 2000 11:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132301AbQLHQxX>; Fri, 8 Dec 2000 11:53:23 -0500
Received: from gw.capgemini.fr ([194.3.247.254]:24228 "EHLO gw.capgemini.fr")
	by vger.kernel.org with ESMTP id <S132294AbQLHQxJ>;
	Fri, 8 Dec 2000 11:53:09 -0500
Message-ID: <3A310A12.446E2C4A@capgemini.fr>
Date: Fri, 08 Dec 2000 17:19:30 +0100
From: Fabien Ribes <fribes@capgemini.fr>
Organization: Cap Gemini Ernst & Young
X-Mailer: Mozilla 4.72 [fr] (X11; U; Linux 2.4.0-test8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Networking: RFC1122 and 1123 status for kernel 2.4
In-Reply-To: <3A30F463.2EE04F4E@capgemini.fr> <200012081454.GAA02632@pizda.ninka.net> <20001208163154.A20038@gruyere.muc.suse.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen a écrit :
> 
> On Fri, Dec 08, 2000 at 06:54:28AM -0800, David S. Miller wrote:
> >    Date:      Fri, 08 Dec 2000 15:46:59 +0100
> >    From: Fabien Ribes <fribes@capgemini.fr>
> >
> >    Looking at Linux kernel sources, I've found RFC1122 status splitted in
> >    each file. Is there a complete document showing RFC1122 status as a
> >    whole for a given kernel version ?
> >
> > No, unfortunately nobody has the time to do this.
> 
> The RFC evaluation is also out of date and should be either redone or removed.

Indeed, what I need is some kind of paper insurance of interoperability
... so I believe grepping the sources for compliances will do the trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
