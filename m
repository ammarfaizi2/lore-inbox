Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTJDITF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 04:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTJDITF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 04:19:05 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:58005 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S261947AbTJDITA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 04:19:00 -0400
Date: Sat, 04 Oct 2003 19:50:18 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [pm] fix oops after saving image
In-reply-to: <20031004080239.GA213@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Stan Bubrouski <stan@ccs.neu.edu>, Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1065253818.14870.27.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20031002203906.GB7407@elf.ucw.cz>
 <Pine.LNX.4.44.0310031433530.28816-100000@cherise>
 <20031003223352.GB344@elf.ucw.cz> <3F7E57E9.8070904@ccs.neu.edu>
 <20031004080239.GA213@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess he means...

On Sat, 2003-10-04 at 20:02, Pavel Machek wrote:
> > >+ *    not freed; its not needed since system is going down anyway

should be

> >+ *    not freed; it's not needed since the system is going down anyway

(it's = it is, its = belongs to it)

and

> > >+ *    (plus it causes oops and I'm lazy^H^H^H^Htoo busy).

should be

> >+ *    (plus it causes an oops and I'm too lazy^H^H^H^Hbusy).

Regards,

Nigel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

