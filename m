Return-Path: <linux-kernel-owner+w=401wt.eu-S1754073AbWLRO1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbWLRO1c (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 09:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbWLRO1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 09:27:32 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:56767 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073AbWLRO1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 09:27:31 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4586A541.2060306@s5r6.in-berlin.de>
Date: Mon, 18 Dec 2006 15:27:13 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] Add PCI class ID for firewire OHCI controllers.
References: <20061217193409.GA19585@devserv.devel.redhat.com>
In-Reply-To: <20061217193409.GA19585@devserv.devel.redhat.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Høgsberg wrote:
> Pull this define out of drivers/ieee1394/ohci1394.c and rename to match
> other PCI class defines.

Committed to linux1394-2.6.git.
-- 
Stefan Richter
-=====-=-==- ==-- =--=-
http://arcgraph.de/sr/
