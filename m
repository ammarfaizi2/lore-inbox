Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVCBMxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVCBMxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 07:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVCBMxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 07:53:23 -0500
Received: from webapps.arcom.com ([194.200.159.168]:10253 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S262281AbVCBMxT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 07:53:19 -0500
Message-ID: <4225B73D.4030700@arcom.com>
Date: Wed, 02 Mar 2005 12:53:17 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kianusch Sayah Karadji <kianusch@sk-tech.net>
CC: davej@codemonkey.org.uk, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: Support for GEODE CPU's in Kernel 2.6.10.
References: <Pine.LNX.4.61.0502272255090.1693@merlin.sk-tech.net>
In-Reply-To: <Pine.LNX.4.61.0502272255090.1693@merlin.sk-tech.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Mar 2005 12:58:48.0171 (UTC) FILETIME=[93148BB0:01C51F27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kianusch Sayah Karadji wrote:
> 
> This is a small patch for GEODE CPU support in Kernel 2.6.10.
> [...]
> +	  - "MediaGX/Geode" for Cyrix MediaGX aka Geode.

How about changing this to:

          - "Geode/MediaGX" for the AMD (formerly National) Geode family
and the Cyrix MediaGX.

And similarly for the MGEODE option and help text?  Since the AMD Geode
family is current and the MediaGX is old.  And perhaps expand the help
text to list the various SoCs since it's not immediately obvious from
their names that they have a Geode core?

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
