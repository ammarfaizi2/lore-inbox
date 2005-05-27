Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVE0IXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVE0IXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 04:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVE0IXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 04:23:40 -0400
Received: from mail.dvmed.net ([216.237.124.58]:57565 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261990AbVE0IXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 04:23:38 -0400
Message-ID: <4296D904.4070406@pobox.com>
Date: Fri, 27 May 2005 04:23:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de> <4295F87B.9070106@pobox.com> <20050527072046.GN1435@suse.de> <4296CC5C.5000807@pobox.com> <20050527073307.GP1435@suse.de> <4296D16F.9030805@pobox.com> <20050527080014.GS1435@suse.de>
In-Reply-To: <20050527080014.GS1435@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Ok, lets get that fixed then... Would you like just a single
> ap->queue_depth and a ATA_DFLAG_NCQ_IN_FLIGHT type flag instead?

works for me

	Jeff


