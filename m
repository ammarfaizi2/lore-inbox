Return-Path: <linux-kernel-owner+w=401wt.eu-S932901AbWL0EYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932901AbWL0EYt (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 23:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932903AbWL0EYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 23:24:49 -0500
Received: from bee.hiwaay.net ([216.180.54.11]:53116 "EHLO bee.hiwaay.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932901AbWL0EYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 23:24:49 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Dec 2006 23:24:48 EST
Date: Tue, 26 Dec 2006 22:17:15 -0600
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: util-linux: orphan
Message-ID: <20061227041715.GA629041@hiwaay.net>
References: <fa.LNsUrtZq/ifve7DpPe6aiVU8Usk@ifi.uio.no> <fa.h6OycRNu7mxizRTmfHAuQj/z8oo@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612270346.10699.arnd@arndb.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Arnd Bergmann  <arnd@arndb.de> said:
>I saw that the current Fedora already dynamically links /bin/mount
>against /usr/lib/libblkid.so.

What do you mean by "current" Fedora?  I think the first Fedora version
that linked /bin/mount against libblkid.so was FC4, and FC4, FC5, FC6,
and rawhide all have libblkid.so in /lib.
-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
