Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbVJaLN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVJaLN4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 06:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVJaLN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 06:13:56 -0500
Received: from cantor.suse.de ([195.135.220.2]:63942 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932296AbVJaLNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 06:13:55 -0500
From: Andreas Schwab <schwab@suse.de>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Rescan SCSI Bus without /proc/scsi?
References: <20051031110344.GA16691@schottelius.org>
X-Yow: Yow!  STYROFOAM..
Date: Mon, 31 Oct 2005 12:13:54 +0100
In-Reply-To: <20051031110344.GA16691@schottelius.org> (Nico Schottelius's
	message of "Mon, 31 Oct 2005 12:03:44 +0100")
Message-ID: <je4q6y547h.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius <nico-kernel@schottelius.org> writes:

> This breaks the popular rescan-scsi-bus.sh from Kurt Garloff.
> Is there a possibility to do that through /sys somehow or do I have
> to reanable /proc/scsi?

Your version of rescan-scsi-bus.sh is quite old.  Current versions of
rescan-scsi-bus.sh already use /sys when available.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
