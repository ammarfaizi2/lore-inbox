Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268350AbRGWWRA>; Mon, 23 Jul 2001 18:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268351AbRGWWQu>; Mon, 23 Jul 2001 18:16:50 -0400
Received: from smtp-rt-13.wanadoo.fr ([193.252.19.223]:38031 "EHLO
	oxera.wanadoo.fr") by vger.kernel.org with ESMTP id <S268350AbRGWWQe>;
	Mon, 23 Jul 2001 18:16:34 -0400
Message-ID: <3B5CA2EC.2498775@wanadoo.fr>
Date: Tue, 24 Jul 2001 00:19:24 +0200
From: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>
Organization: CoolSite
X-Mailer: Mozilla 4.74 [fr] (X11; U; Linux 2.4.4-sb i686)
X-Accept-Language: French, fr, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
        linux-fsdev@vger.kernel.org, martizab@libertsurf.fr,
        rusty@rustcorp.com.au
Subject: Re: Yet another linux filesytem: with version control
In-Reply-To: <Pine.LNX.4.33L.0107231850200.20326-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Rik van Riel a écrit :
> 
> On Mon, 23 Jul 2001, Larry McVoy wrote:
> 
> > b) Filesystem support for SCM is really a flawed approach.
> 
> Agreed.  I mean, how can you cleanly group changesets and
> versions with a filesystem level "transparent" SCM ?

With label !

In my initial post, i have explain that labels are used to 
identify individual files AND are also uses to select for 
each files of a set, one version (= select a configuration). 
It works !


> 
> The goal of an SCM is to _manage_ versions and changesets,
> if it doesn't do that we're back at CVS's "every file its
> own versioning and to hell with manageability" ...

versioning is yet a first step.

j.

-- 
Jerome de Vivie 	jerome . de - vivie @ wanadoo . fr
