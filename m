Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVCAIpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVCAIpO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 03:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVCAIpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 03:45:14 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:52367 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261743AbVCAIpG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 03:45:06 -0500
X-Envelope-From: kraxel@bytesex.org
To: James Bruce <bruce@andrew.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Potentially dead bttv cards from 2.6.10
References: <422001CD.7020806@andrew.cmu.edu> <20050228134410.GA7499@bytesex>
	<42232DFC.6090000@andrew.cmu.edu> <87mzto3c78.fsf@bytesex.org>
	<42240EB3.6040504@andrew.cmu.edu>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 01 Mar 2005 09:44:42 +0100
In-Reply-To: <42240EB3.6040504@andrew.cmu.edu>
Message-ID: <87is4b21s5.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bruce <bruce@andrew.cmu.edu> writes:

> If you could suggest a very well tested kernel for bttv (2.6.9?),

What do you expect?  With just one single report and not remotely
being clear what exactly caused it ...

> I've heard that there is some way to dump eeproms; Is there a way to
> write them also?

Yes, you can.  That works only if you can still talk to it though.

> If I could copy the eeprom from the unused cards to the (now broken)
> pair that might fix things.

No.  It's not accessable, not just the content scrambled.

  Gerd
 
-- 
#define printk(args...) fprintf(stderr, ## args)
