Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280850AbRKBV57>; Fri, 2 Nov 2001 16:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280852AbRKBV5t>; Fri, 2 Nov 2001 16:57:49 -0500
Received: from adsl-63-206-69-238.dsl.snfc21.pacbell.net ([63.206.69.238]:64519
	"EHLO www.baywinds.org") by vger.kernel.org with ESMTP
	id <S280850AbRKBV5l>; Fri, 2 Nov 2001 16:57:41 -0500
Message-ID: <3BE316CE.8ABA1454@baywinds.org>
Date: Fri, 02 Nov 2001 13:57:34 -0800
From: Bruce Ferrell <bferrell@baywinds.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Bernd Eckenfels <ecki@lina.inka.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: unnumbered interfaces? - OT
In-Reply-To: <E15zV7P-0003pM-00@calista.inka.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bernd Eckenfels wrote:
> 
> In article <200111011522.QAA22531@zhadum.sara.nl> you wrote:
> >> I'm trying to understand unnumbered interfaces.  From
> >> searching the web, they seem to be point-to-point links
> >> that do not have IP numbers (hence the name).

They are in fact, used for point-to-point links.  It allows someone to
build a kind of distributed router; Kind of like the old IBM remote
bridge arrangemets.  Those had either a token ring or ethernet card and
a WAN card of some kind (usually SDLC or X.25) connecting them
together.  Kind of cool in a weird, expensive sort of way.

> It is Cisco Speak. In Linux you simply give the Interface an IP Address of
> an exisiting Interface, and then you have an "unnumbered" interface. It
> simply means it does not add an additional address.
> 
> Routing in modern operating systems is so easy and natural with interface
> and host routes, dont worry about cisco legacy.
> 
> Greetings
> Bernd
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
