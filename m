Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVA3IJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVA3IJg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 03:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVA3IJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 03:09:36 -0500
Received: from pD9F875BD.dip0.t-ipconnect.de ([217.248.117.189]:27520 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S261658AbVA3IJd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 03:09:33 -0500
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: Software Suspend for 2.4 Final Release
Date: Sun, 30 Jan 2005 09:07:23 +0100
Organization: privat
Message-ID: <cti4jq$27m$1@pD9F875BD.dip0.t-ipconnect.de>
References: <fa.h8ov4ea.uhmkao@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@fu.berlin.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.5) Gecko/20050128
X-Accept-Language: de, en-us, en
In-Reply-To: <fa.h8ov4ea.uhmkao@ifi.uio.no>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham schrieb:
> Hi everyone.
> 
> SoftwareSuspend 2.1.5.7B for the 2.4.28 kernel is now available from
> softwaresuspend.berlios.de.

I'm wondering why you didn't provide a patch against 2.4.29.

Anyway, I tested it against 2.4.29. I couldn't apply the preemption patch.
The other patches could be applied with a view changes. 2.1.5.7B is
working fine afterwards - even without restarting sleeping hd's during
hibernation! Thank you very much for fixing this problem!



Kind regards,
Andreas Hartmann
