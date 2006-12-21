Return-Path: <linux-kernel-owner+w=401wt.eu-S1423089AbWLUXDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423089AbWLUXDU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 18:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423108AbWLUXDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 18:03:20 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:36463 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423089AbWLUXDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 18:03:19 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <458B12A4.5000402@s5r6.in-berlin.de>
Date: Fri, 22 Dec 2006 00:03:00 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] New firewire stack - updated patches
References: <20061220005822.GB11746@devserv.devel.redhat.com>
In-Reply-To: <20061220005822.GB11746@devserv.devel.redhat.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Høgsberg wrote:
> Here's a new set of patches for the new firewire stack.
...
> It is still work in progress, but at least now it should work across
> all architectures and endianesses.

Committed to linux1394-2.6.git.

BTW, I prepended "ieee1394:" to the titles of most of the commits to
this tree. From now on I will always do this on commits affecting
mainline's FireWire stack, and prepend "firewire:" to the titles of
commits affecting the JUJU stack. It's redundant but IMO helpful when
reading changelogs.
-- 
Stefan Richter
-=====-=-==- ==-- =-=-=
http://arcgraph.de/sr/
