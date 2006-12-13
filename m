Return-Path: <linux-kernel-owner+w=401wt.eu-S965020AbWLMQou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWLMQou (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 11:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWLMQou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 11:44:50 -0500
Received: from mga07.intel.com ([143.182.124.22]:7295 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965026AbWLMQot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 11:44:49 -0500
X-Greylist: delayed 692 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 11:44:49 EST
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,164,1165219200"; 
   d="scan'208"; a="157748282:sNHT38913455"
Message-ID: <45802B3A.6060208@linux.intel.com>
Date: Wed, 13 Dec 2006 17:32:58 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Arkadiusz Miskiewicz <arekm@maven.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: announce: irqbalance 0.55 released
References: <1165865249.27217.419.camel@laptopd505.fenrus.org> <200612131717.48857.arekm@maven.pl>
In-Reply-To: <200612131717.48857.arekm@maven.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arkadiusz Miskiewicz wrote:
> Manual page disappeared (no big problem, wasn't even complete).

someone submitted a new one yesterday, it's in the SVN repo

> X Window tools 
> are required to build it (gccmakedep). Uh.

hmm that's part of X???? wtf

> 
> Looks like parameters also have changed and are incompatible with previous 
> irqbalance (--option vs option now).

both -- and without work btw



> Long standing typo:
>         "eepro100",
>         "orinico_cs",
>       ^^^^^^^^^^^^^^^

ok woops fixing...
