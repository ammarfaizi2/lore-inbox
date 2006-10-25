Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161310AbWJYSx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161310AbWJYSx0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 14:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbWJYSx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 14:53:26 -0400
Received: from ns1.suse.de ([195.135.220.2]:13257 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030467AbWJYSxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 14:53:25 -0400
To: Om Narasimhan <om.turyx@gmail.com>
Cc: randy.dunlap@oracle.com, omanakuttan.potty@sun.com, clemens@ladisch.de,
       vojtech@suse.cz, bob.picco@hp.com, venkatesh.pallipadi@intel.com,
       omanakuttan@imap.cc, linux-kernel@vger.kernel.org
Subject: Re: HPET : Legacy Routing Replacement Enable - 3rd try.
References: <200610250013.48194.om.turyx@gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 25 Oct 2006 20:53:12 +0200
In-Reply-To: <200610250013.48194.om.turyx@gmail.com>
Message-ID: <p731wowmdlz.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Om Narasimhan <om.turyx@gmail.com> writes:

> I have incorporated Randy's comments.
> CC-ing HPET developers.

Can you please: 

- split it up in i386/x86-64/generic
- write a full description for each piece
- give a rationale why you're implementing this

Thanks

-Andi
