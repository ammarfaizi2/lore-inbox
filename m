Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129772AbRCERNo>; Mon, 5 Mar 2001 12:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129470AbRCERNc>; Mon, 5 Mar 2001 12:13:32 -0500
Received: from mail.inf.tu-dresden.de ([141.76.2.1]:8816 "EHLO
	mail.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S129797AbRCERNI>; Mon, 5 Mar 2001 12:13:08 -0500
Date: Mon, 5 Mar 2001 18:12:52 +0100
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jeremy Jackson <jerj@coplanar.net>, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: anti-spam regexps
Message-ID: <20010305181252.A1589@ugly.wh8.tu-dresden.de>
In-Reply-To: <3AA3909D.805707AB@coplanar.net> <Pine.LNX.4.21.0103051221130.5591-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.21.0103051221130.5591-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Mon, Mar 05, 2001 at 12:23:13PM -0300
From: Oswald Buddenhagen <ob6@inf.tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anybody interested in the ~100 anti-spam regexps I'm using
> on NL.linux.org at the moment ?
> 
there is a much simpler method:
drop any mail, which does not contain the address of the mailing list
in To: or Cc:. 
Bcc: mails (who wants to post with a bcc legitimately?) and bulk
mailers (which don't put the receipients into the headers) are
rejected. this does not only protect from spam, but also from the
jerks, that subscribe one mailing list to another. 
or did i miss some important point?

best regards

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
--
Nothing is fool-proof to a sufficiently talented fool.
