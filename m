Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUB0Wml (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUB0Wml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 17:42:41 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:62960 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S263181AbUB0Wlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 17:41:52 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] Linux hotplug memory mailing list created
Date: Fri, 27 Feb 2004 23:34:17 +0100
User-Agent: KMail/1.5.4
Cc: linux-hotplug-memory@lists.sourceforge.net
References: <20040227215349.GA12122@kroah.com>
In-Reply-To: <20040227215349.GA12122@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402272334.17554.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 February 2004 22:53, Greg KH wrote:

> As I personally know of at least 3 different groups at 3 different
> companies working on this feature, and all of them don't seem to want to
> talk together on linux-kernel or linux-mm, this list is for them, and
> anyone else who wants to help.

Does this already include the s390 kernel team? We are definitely
interested in this. Note that we already have one (rather limited)
solution for memory unplug in arch/s390/mm/cmm.c, but this is far
from real memory hotplug and uses an architecture feature that is
probably not available anywhere else.

	Arnd <><

