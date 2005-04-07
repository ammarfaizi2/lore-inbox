Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVDGHZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVDGHZo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 03:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVDGHZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 03:25:44 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:49132 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S261839AbVDGHZZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 03:25:25 -0400
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <greg@kroah.com>, Sven Luther <sven.luther@wanadoo.fr>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org,
       linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
References: <20050404100929.GA23921@pegasos>
	<87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos>
	<20050404175130.GA11257@kroah.com>
	<20050404183909.GI18349@parcelfarce.linux.theplanet.co.uk>
From: Jes Sorensen <jes@wildopensource.com>
Date: 07 Apr 2005 03:25:22 -0400
In-Reply-To: <20050404183909.GI18349@parcelfarce.linux.theplanet.co.uk>
Message-ID: <yq08y3vxd3x.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matthew" == Matthew Wilcox <matthew@wil.cx> writes:

Matthew> On Mon, Apr 04, 2005 at 10:51:30AM -0700, Greg KH wrote:
>> Then let's see some acts.  We (lkml) are not the ones with the
>> percieved problem, or the ones discussing it.

Matthew> Actually, there are some legitimate problems with some of the
Matthew> files in the Linux source base.  Last time this came up, the
Matthew> Acenic firmware was mentioned:

Matthew> http://lists.debian.org/debian-legal/2004/12/msg00078.html

Matthew> Seems to me that situation is still not resolved.

Well whoever wrote that seems to have taken the stand that the
openfirmware package was were the firmware came from. The person
obviously made a lot of statements without bothering checking out the
real source. Well it didn't come from there, I got it from Alteon
under a written agreement stating I could distribute the image under
the GPL. Since the firmware is simply data to Linux, hence keeping it
under the GPL should be just fine.

If someone wishes to post a patch adding a GPL header to the
acenic_firmware.h file, fine with me. But beyond that I consider the
case closed.

Regards,
Jes
