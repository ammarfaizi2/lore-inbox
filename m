Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWHWFZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWHWFZx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 01:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWHWFZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 01:25:53 -0400
Received: from asia.telenet-ops.be ([195.130.137.74]:58262 "EHLO
	asia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1751384AbWHWFZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 01:25:53 -0400
From: Peter Korsgaard <jacmet@sunsite.dk>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, device@lanana.org
Subject: Re: [PATCH] Update Documentation/devices.txt
References: <87d5aserky.fsf@slug.be.48ers.dk>
	<20060822092458.7fbc5286.rdunlap@xenotime.net>
Date: Wed, 23 Aug 2006 07:25:37 +0200
In-Reply-To: <20060822092458.7fbc5286.rdunlap@xenotime.net> (Randy Dunlap's
	message of "Tue, 22 Aug 2006 09:24:58 -0700")
Message-ID: <87wt902fce.fsf@slug.be.48ers.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Randy" == Randy Dunlap <rdunlap@xenotime.net> writes:

Hi.

 >> Maintained by Torben Mathiasen <device@lanana.org>

 Randy> Maybe Torben could update or ack/nack or comment?

Yeah - Torben?

 >> @@ -1522,7 +1522,7 @@ Your cooperation is appreciated.
 >> disks (see major number 3) except that the limit on
 >> partitions is 15.
 >> 
 >> - 83 char	Matrox mga_vid video driver
 >> + 83 char	Matrox mga_vid video driver 

 Randy> Please don't add trailing whitespace like above.

I've just taken the file from lanana.org verbatim. I can fix the
issues in the patch or try to get Torben to change it on lanana.org,
but his turnaround time is pretty slow (took ~3 months for my ttyULx
nodes).

-- 
Bye, Peter Korsgaard
