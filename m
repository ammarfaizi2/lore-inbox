Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751784AbWJMSei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWJMSei (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWJMSei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:34:38 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:1553 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S1751779AbWJMSeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:34:37 -0400
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shaggy@austin.ibm.com
Subject: Re: Linux 2.6.19-rc2
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
Date: Fri, 13 Oct 2006 11:34:26 -0700
In-Reply-To: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> (message from
	Linus Torvalds on Fri, 13 Oct 2006 09:49:29 -0700 (PDT))
Message-ID: <87irio12vh.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> So if you had issues with -rc1 (which had a ton of merges - even
> more so than most -rc1 releases, I think), this should hopefully be
> a lot better.

airo driver suspend is still broken. i still need to apply the patch
posted originally at (with an explanation of why airo suspend is not
working anymore)
http://marc.theaimsgroup.com/?l=linux-kernel&m=116025080215854&w=2 to
get the driver to suspend. (the patch still applies to 2.6.19-rc2 with
minor fuzz).

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
