Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932648AbWCAIia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbWCAIia (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 03:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbWCAIia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 03:38:30 -0500
Received: from mail.gmx.de ([213.165.64.20]:26533 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932279AbWCAIi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 03:38:29 -0500
X-Authenticated: #428038
Date: Wed, 1 Mar 2006 09:38:24 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: Mark Rustad <mrustad@mac.com>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: sg regression in 2.6.16-rc5
Message-ID: <20060301083824.GA9871@merlin.emma.line.org>
Mail-Followup-To: Douglas Gilbert <dougg@torque.net>,
	Mark Rustad <mrustad@mac.com>, linux-scsi@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com> <4404AA2A.5010703@torque.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4404AA2A.5010703@torque.net>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2006, Douglas Gilbert wrote:

> You can stop right there with the 1 MB reads. Welcome
> to the new, blander sg driver which now shares many
> size shortcomings with the block subsystem.

What is the reason to break user-space applications like this?

-- 
Matthias Andree
