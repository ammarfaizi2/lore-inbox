Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130126AbRCESIB>; Mon, 5 Mar 2001 13:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130170AbRCESHv>; Mon, 5 Mar 2001 13:07:51 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:43259 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130126AbRCESHj>; Mon, 5 Mar 2001 13:07:39 -0500
Date: Mon, 5 Mar 2001 15:07:17 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Oswald Buddenhagen <ob6@inf.tu-dresden.de>
cc: Jeremy Jackson <jerj@coplanar.net>, <linux-kernel@vger.kernel.org>,
        <linux-kernel-owner@vger.kernel.org>
Subject: Re: anti-spam regexps
In-Reply-To: <20010305181252.A1589@ugly.wh8.tu-dresden.de>
Message-ID: <Pine.LNX.4.33.0103051504150.1409-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Oswald Buddenhagen wrote:

> > Anybody interested in the ~100 anti-spam regexps I'm using
> > on NL.linux.org at the moment ?
> >
> there is a much simpler method:
> drop any mail, which does not contain the address of the mailing list
> in To: or Cc:.
> Bcc: mails (who wants to post with a bcc legitimately?) and bulk
> mailers (which don't put the receipients into the headers)

Unfortunately, spam to lists often *does* contain the list
address in the To: or Cc: header these days ...

... but it does contain all the usual spam disclaimers.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

