Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWAKWT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWAKWT0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWAKWT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:19:26 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:61390 "EHLO
	localhost") by vger.kernel.org with ESMTP id S932279AbWAKWTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:19:25 -0500
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Place for userland swsusp parts
Date: Thu, 12 Jan 2006 08:19:42 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       kernel list <linux-kernel@vger.kernel.org>
References: <20060111221511.GA8223@elf.ucw.cz>
In-Reply-To: <20060111221511.GA8223@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601120819.42512.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thursday 12 January 2006 08:15, Pavel Machek wrote:
> Hi!
>
> Is there some place where we could  put userland swsusp parts under
> version control?
>
> swsusp.sf.net looks like possible place, but it has been in use by
> suspend2... Is it still being used? If not, would it be possible to
> "hijack" it for swsusp development?

It's not still being used (we have suspend2.net now). The only problem I see 
with that is that it still has all the old suspend2 stuff and Sourceforge 
make it really hard to clear out a project's files. You were talking about 
calling it uswsusp or something like that. How about starting a 
uswsusp.sf.net?

Regards,

Nigel
-- 
Nigel, Michelle and Alisdair Cunningham
72 Brownie Street, Jamboree Heights
Brisbane 4074, Australia
+61 (7) 3279 6728
