Return-Path: <linux-kernel-owner+w=401wt.eu-S965015AbWLMQeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbWLMQeb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 11:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWLMQea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 11:34:30 -0500
Received: from outgoing1.smtp.agnat.pl ([193.239.44.83]:50316 "EHLO
	outgoing1.smtp.agnat.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965026AbWLMQe3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 11:34:29 -0500
X-Greylist: delayed 984 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 11:34:29 EST
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Organization: SelfOrganizing
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: announce: irqbalance 0.55 released
Date: Wed, 13 Dec 2006 17:17:48 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <1165865249.27217.419.camel@laptopd505.fenrus.org>
In-Reply-To: <1165865249.27217.419.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612131717.48857.arekm@maven.pl>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 December 2006 20:27, Arjan van de Ven wrote:

> At this point only source packages are available, I hope that the linux
> vendors will have packages for the various distributions ready in a few
> days.
Manual page disappeared (no big problem, wasn't even complete). X Window tools 
are required to build it (gccmakedep). Uh.

Looks like parameters also have changed and are incompatible with previous 
irqbalance (--option vs option now).

Long standing typo:
        "eepro100",
        "orinico_cs",
      ^^^^^^^^^^^^^^^
        "wvlan_cs",

> Greetings,
>    Arjan van de Ven

-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
