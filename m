Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUIOM5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUIOM5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 08:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUIOM4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 08:56:43 -0400
Received: from holomorphy.com ([207.189.100.168]:58011 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265978AbUIOMyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:54:02 -0400
Date: Wed, 15 Sep 2004 05:53:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
Message-ID: <20040915125355.GS9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040915113635.GO9106@holomorphy.com> <20040915113833.GA4111@suse.de> <20040915122852.GQ9106@holomorphy.com> <20040915124124.GC4111@suse.de> <20040915125056.GD4111@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915125056.GD4111@suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15 2004, Jens Axboe wrote:
>> Hmm, I can only see this happening if rq->flags has its direction bit
>> changed between the allocation time and the time of freeing. I'll look
>> over scsi and see if I can find any traces of that, don't see any
>> immediately.

On Wed, Sep 15, 2004 at 02:50:57PM +0200, Jens Axboe wrote:
> Can you try if this works?

Booting it ASAP.


-- wli
