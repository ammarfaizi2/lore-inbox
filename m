Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWBVIuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWBVIuu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 03:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbWBVIuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 03:50:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:29399 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932348AbWBVIut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 03:50:49 -0500
X-Authenticated: #428038
From: Matthias Andree <matthias.andree@gmx.de>
To: dougg@torque.net
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       taggart@debian.org
Subject: Re: lsscsi-0.17 released
In-Reply-To: <43FBA4CD.6000505@torque.net> (Douglas Gilbert's message of "Tue,
	21 Feb 2006 18:39:57 -0500")
References: <43FBA4CD.6000505@torque.net>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
Date: Wed, 22 Feb 2006 09:50:45 +0100
Message-ID: <m34q2r93q2.fsf@merlin.emma.line.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert <dougg@torque.net> writes:

> Version 0.17 is available at
> http://www.torque.net/scsi/lsscsi.html
> More information can be found on that page including examples
> and a Download section for tarballs and rpms.
> This version will be required for lsscsi to work properly
> when lk 2.6.16 is released.
>
> ChangeLog:
> Version 0.17 2006/2/6
>   - fix disappearance of block device names in lk 2.6.16-rc1

Does this work around new incompatibilities in the kernel
or does this fix lsscsi bugs?

-- 
Matthias Andree
