Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVHPUln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVHPUln (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 16:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVHPUln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 16:41:43 -0400
Received: from ns1.suse.de ([195.135.220.2]:20425 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932434AbVHPUlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 16:41:42 -0400
From: Andreas Schwab <schwab@suse.de>
To: vamsi krishna <vamsi.krishnak@gmail.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Multiple virtual address mapping for the same code on IA-64 linux kernel.
References: <3faf056805081613365f5237de@mail.gmail.com>
X-Yow: Look!!  Karl Malden!
Date: Tue, 16 Aug 2005 22:41:39 +0200
In-Reply-To: <3faf056805081613365f5237de@mail.gmail.com> (vamsi krishna's
	message of "Wed, 17 Aug 2005 02:06:26 +0530")
Message-ID: <je1x4tbon0.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vamsi krishna <vamsi.krishnak@gmail.com> writes:

> example /lib/libc-2.2.4.so size 6094859    got mapped 3 times with
> permissions 'r-xp' , '---p' and 'rw-p' from the bottom.

Note the file offset.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
