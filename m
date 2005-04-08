Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbVDHJeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbVDHJeT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 05:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbVDHJeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 05:34:18 -0400
Received: from kruuna.helsinki.fi ([128.214.205.14]:1698 "EHLO
	kruuna.helsinki.fi") by vger.kernel.org with ESMTP id S262775AbVDHJd6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 05:33:58 -0400
From: Atro Tossavainen <atossava@cc.helsinki.fi>
Message-Id: <200504080926.j389QO1e004967@kruuna.helsinki.fi>
Subject: Re: CCISS problems continue with 2.4.28
In-Reply-To: <20050114210750.GA24705@beardog.cca.cpqcorp.net>
To: mikem <mikem@beardog.cca.cpqcorp.net>
Date: Fri, 8 Apr 2005 12:26:24 +0300 (EEST)
CC: linux-kernel@vger.kernel.org
Reply-To: Atro.Tossavainen@helsinki.fi
X-Mailer: ELM [version 2.4ME+ PL121e (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike,

On Fri, 14 Jan 2005 15:07:50 -0600, you wrote:

> Sorry, I let this one drop though the cracks. Try booting with acpi=off.
> It appears the interrupt is not being detected properly. If acpi=off works
> try updating the system ROM. We have been known to have buggy acpi tables.

acpi=off works, but the 09/15/2004 P29 flash update to the DL380 G3
(SP28809) doesn't make the problem go away.

-- 
Atro Tossavainen (Mr.)               / The Institute of Biotechnology at
Systems Analyst, Techno-Amish &     / the University of Helsinki, Finland,
+358-9-19158939  UNIX Dinosaur     / employs me, but my opinions are my own.
< URL : http : / / www . helsinki . fi / %7E atossava / > NO FILE ATTACHMENTS
