Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266825AbUFYSGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUFYSGV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 14:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266828AbUFYSGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 14:06:21 -0400
Received: from zork.zork.net ([64.81.246.102]:50329 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S266825AbUFYSEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 14:04:46 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
References: <40DB605D.6000409@comcast.net> <6uhdsz3jud.fsf@zork.zork.net>
	<40DC685E.1020406@techsource.com>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Fri, 25 Jun 2004 19:04:45 +0100
In-Reply-To: <40DC685E.1020406@techsource.com> (Timothy Miller's message of
	"Fri, 25 Jun 2004 14:01:02 -0400")
Message-ID: <6uoen71pky.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> writes:

> Sean Neakums wrote:
>> I seem to remember somebody, I think maybe Andrew Morton, suggesting
>> that a no-journal mode be added to ext3 so that ext2 could be removed.
>> I can't find the message in question right now, though.
>
> As an option, that might be nice, but if everyone were to start using
> ext3 even for their non-journalled file systems, the ext2 code would
> be subject to code rot.

My paraphrase is at fault here.  In the above, "removed" == "removed
from the kernel tree".
