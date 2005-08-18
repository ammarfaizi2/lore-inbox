Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVHRCFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVHRCFJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 22:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVHRCFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 22:05:09 -0400
Received: from mail.suse.de ([195.135.220.2]:40112 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932094AbVHRCFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 22:05:07 -0400
To: e8607062@student.tuwien.ac.at
Cc: Elliot Lee <sopwith@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process (update)
References: <1124326652.8359.3.camel@w2>
From: Andi Kleen <ak@suse.de>
Date: 18 Aug 2005 04:05:02 +0200
In-Reply-To: <1124326652.8359.3.camel@w2>
Message-ID: <p7364u40zld.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wieland Gmeiner <e8607062@student.tuwien.ac.at> writes:

Is there a realistic use case where this new system call is actually useful
and solves something that cannot be solved without it?

If not I think it's better not to merge this to avoid unnecessary bloat.

-Andi
