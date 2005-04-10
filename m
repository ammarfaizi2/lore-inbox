Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVDJT3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVDJT3m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 15:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVDJT3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 15:29:41 -0400
Received: from hermes.domdv.de ([193.102.202.1]:46085 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261585AbVDJT3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 15:29:30 -0400
Message-ID: <42597E99.8010802@domdv.de>
Date: Sun, 10 Apr 2005 21:29:29 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: pavel@suse.cz, Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zero disk pages used by swsusp on resume
References: <42592697.8060909@domdv.de> <200504102040.38403.oliver@neukum.org>
In-Reply-To: <200504102040.38403.oliver@neukum.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> What is the point in doing so after they've rested on the disk for ages?

The point is not physical access to the disk but data gathering after
resume or reboot.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
