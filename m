Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTDZQUd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 12:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTDZQUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 12:20:33 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:24080 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S261876AbTDZQUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 12:20:32 -0400
Date: Sat, 26 Apr 2003 18:32:43 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Tom Dietz <tom@glis.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3ware 7500 RAID problems....
In-Reply-To: <000001c30c03$38963870$6501a8c0@typhoon>
Message-ID: <Pine.LNX.4.44.0304261823330.18264-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom!

On Sat, 26 Apr 2003, Tom Dietz wrote:

> I recently upgraded to RedHat 9.0 only to find that my 600GB RAID system no
> longer works.  It worked fine with RH 8.0, however once I upgraded, it no
> longer came up cleanly and I got lots of error messages during boot.
> 
When updating the 3ware driver (as part of the kernel update), 3ware's website 
recommends updating the firmware, too. See e.g.

http://www.3ware.com/download/Escalade7000Series/7.6/7.6_Release_Notes_Web.pdf

for matching versions of the firmware, driver and 3dmd.

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

"If you think NT is the answer, you didn't understand the question."
						- Paul Stephens

