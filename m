Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVGQTmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVGQTmA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 15:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVGQTmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 15:42:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:32407 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261346AbVGQTl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 15:41:56 -0400
From: Andreas Schwab <schwab@suse.de>
To: "Nathanael Nerode" <neroden@twcny.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linus's git tree broken?
References: <20050717100940.GA22224@twcny.rr.com>
X-Yow: He is the MELBA-BEING...  the ANGEL CAKE...
  XEROX him...  XEROX him --
Date: Sun, 17 Jul 2005 21:41:54 +0200
In-Reply-To: <20050717100940.GA22224@twcny.rr.com> (Nathanael Nerode's message
	of "Sun, 17 Jul 2005 06:09:40 -0400")
Message-ID: <jeu0itxlrx.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nathanael Nerode" <neroden@twcny.rr.com> writes:

> $ cg-clone http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> defaulting to local storage area
> 06:02:39 URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/heads/master [41/41] -> "refs/heads/origin" [1]
> progress: 2 objects, 897 bytes
> error: File 2a7e338ec2fc6aac461a11fe8049799e65639166 (http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/2a/7e338ec2fc6aac461a11fe8049799e65639166) corrupt

You need to use the rsync method, http does not work with Linus' tree.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
