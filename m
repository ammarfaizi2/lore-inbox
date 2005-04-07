Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVDGH26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVDGH26 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 03:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVDGH26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 03:28:58 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:53996 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S261640AbVDGH2w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 03:28:52 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Matthew Wilcox <matthew@wil.cx>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
References: <20050404100929.GA23921@pegasos>
	<87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos>
	<20050404175130.GA11257@kroah.com>
	<20050404183909.GI18349@parcelfarce.linux.theplanet.co.uk>
	<42519BCB.2030307@pobox.com> <20050404202706.GB3140@pegasos>
	<4251A7E8.6050200@pobox.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 07 Apr 2005 03:28:50 -0400
In-Reply-To: <4251A7E8.6050200@pobox.com>
Message-ID: <yq04qejxcy5.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@pobox.com> writes:

Jeff> Sven Luther wrote:
>> Yep, but in the meantime, let's clearly mark said firmware as
>> not-covered-by-the-GPL. In the acenic case it seems to be even
>> easier, as the firmware is in a separate acenic_firmware.h file,
>> and it just needs to have the proper licencing statement added,
>> saying that it is not covered by the GPL, and then giving the
>> information under what licence it is being distributed.

Jeff> Who has meaningfully contacted Alteon (probably "Neterion" now)
Jeff> about this?  What is the progress of that request?

Whoever actually owns the rights to the firmware these days is going
to be practically impossible to track down. The rights were sold off
left and right when Alteon sold out to Nortel and Nortel then
imploded. 

The s2io/neterion guys may or may not know, but I doubt anyone is
willing to spend real company manhours trying to track down a legal
trace for a dead product which hasn't been manufactured for years and
nobody really cares about technology wise anymore.

Regards,
Jes
