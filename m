Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbTH2F7P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 01:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbTH2F7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 01:59:14 -0400
Received: from tmi.comex.ru ([217.10.33.92]:56973 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S264449AbTH2F7O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 01:59:14 -0400
X-Comment-To: =?iso-8859-1?q?Ram=F3n?= Rey =?koi8-r?b?VmljZW50ZfOuoJI=?=
To: =?iso-8859-1?q?Ram=F3n?= Rey =?koi8-r?b?VmljZW50ZfOu?= 
	<retes_simbad@yahoo.es>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] extents support for EXT3
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Fri, 29 Aug 2003 10:04:41 +0400
In-Reply-To: <1062086590.2623.3.camel@debian> =?iso-8859-1?q?(Ram=F3n?= Rey
 =?koi8-r?b?VmljZW50ZfOuoJIncw==?= message of "Fri, 29 Aug 2003 00:00:45
 +0200")
Message-ID: <m3r835rocm.fsf@bzzz.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <m33cfm19ar.fsf@bzzz.home.net> <1062086590.2623.3.camel@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> RamÃ³n Rey Vicenteó®  (RRV) writes:

 RRV> This patch could be included with ext3 in 2.6.x?

well, as Andreas already said I don't try to get this patch into 2.6.
this is impossible, obviously. lots of work need to be done before mainline.
userspace utility (fsck, debugfs) should be prepared. at this time
I'd like to get comments, suggestions and wider testing, of course ;)

