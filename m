Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTL2Oqw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 09:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTL2Oqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 09:46:52 -0500
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:33214 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP id S263486AbTL2Oqv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 09:46:51 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm2
References: <20031229013223.75c531ed.akpm@osdl.org>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Mon, 29 Dec 2003 09:46:50 -0500
In-Reply-To: <20031229013223.75c531ed.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 29 Dec 2003 01:32:23 -0800")
Message-ID: <9cffzf365r9.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> .. Added the adaptec SCSI driver update from Justin.  There's some
>   disagreement over whether the changes in this patch are appropriate, but we
>   may as well get some external testing underway.

I found that adding Justin's 6.3.3 to a clean 2.6.0 kernel would cause
an oops on booting when starting that driver.  Sorry to say I didn't
jot down the oops, but I'm very interested to hear how this works for
anyone else.

Ian

