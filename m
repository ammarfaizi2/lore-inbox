Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTFTMyf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 08:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbTFTMyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 08:54:35 -0400
Received: from gherkin.frus.com ([192.158.254.49]:61057 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S263103AbTFTMye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 08:54:34 -0400
Subject: Re: 2.5.72: SCSI tape error handling
In-Reply-To: <Pine.LNX.4.52.0306201505210.755@kai.makisara.local>
 "from Kai Makisara at Jun 20, 2003 03:11:29 pm"
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Date: Fri, 20 Jun 2003 08:08:34 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20030620130834.BCA4C4F01@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Makisara wrote:
> st does not currently return error for any write problems except when at
> EOT. The following one-liner fixes the bug (probably mangled by my mail
> client):
> 
> (...)
>
> Thanks for the report.

Thank *you* for the fix!  With disk drive capacities greatly
outstripping my budgetary ability to buy tape drives that are up to the
task, I don't know how much longer I'll consider tape to be a viable
backup option, but I can now hang in there a bit longer :-).

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
