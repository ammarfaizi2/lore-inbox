Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265118AbUEUXKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbUEUXKB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265117AbUEUXJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:09:23 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:18449 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S265100AbUEUXCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:02:54 -0400
Date: Thu, 20 May 2004 11:20:47 +0200
From: DervishD <raul@pleyades.net>
To: "Emiliano 'AlberT' Gabrielli" <AlberT@SuperAlberT.it>
Cc: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: [OT ML related]
Message-ID: <20040520092047.GE30708@DervishD>
Mail-Followup-To: Emiliano 'AlberT' Gabrielli <AlberT@SuperAlberT.it>,
	Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0405191118170.4760@rosencrantz.theboonies.us> <200405201019.51259.AlberT@SuperAlberT.it> <20040520085403.GA17391@middle.of.nowhere> <200405201109.29864.AlberT@SuperAlberT.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200405201109.29864.AlberT@SuperAlberT.it>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Emiliano :)

 * Emiliano 'AlberT' Gabrielli <AlberT@SuperAlberT.it> dixit:
> On 10:54, giovedì 20 maggio 2004, Jurriaan wrote:
> > > My propose is to prepend every message coming from this ML with a fixed
> > > and significant string, my choice is "[LKML]: "
> > Use procmail and do it yourself.
> uhm... what a nice answer...

    It is, really, because it you look at the headers of messages
coming from the LKML, they have a X-Mailing-List header you can use
for filtering, so there is no need to add a string in the subject. If
you look at common subjects in this list, you can see some of them
are pretty large, so prepending '[LKML]:' will be bloat.

    You can use procmail to do that filtering based upon the
X-Mailing-List header, but you can also use your Mail User Agent to
do more or less the same. I see you use KMail, and I don't know if
you can use it to filter messages, but you can do with mutt or elmo
(AFAIK) without procmail.

    IMHO, adding a string to the subject (I assume that you were
talking about adding the string to the subject and not to the message
body) is not needed and will impose visual clutter. If you cannot (or
don't want to) use procmail, try to do the filtering with your MUA if
it is powerful enough.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
