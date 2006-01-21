Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWAUX0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWAUX0G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 18:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWAUX0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 18:26:06 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:56125 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751222AbWAUX0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 18:26:03 -0500
Date: Sat, 21 Jan 2006 18:26:02 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
In-reply-to: <20060119030251.GG19398@stusta.de>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200601211826.02159.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060119030251.GG19398@stusta.de>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 January 2006 22:02, Adrian Bunk wrote:
>Let's do the scheduled removal of the obsolete raw driver in 2.6.17.

This thread has run on for a bit longer it seems, and it prompts me to 
back up to the original post and ask if the raw driver you are removing 
is the raw driver used when cups tells a device (a printer) to do this 
file using the -o raw format?

If this is the case, then a rather large amount of printing 
functionality will be removed as a side effect.  I hope I'm 
miss-understanding the intent here.

[huge snippage]

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
