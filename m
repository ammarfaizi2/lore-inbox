Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbTJMUVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 16:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTJMUVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 16:21:55 -0400
Received: from code.and.org ([63.113.167.33]:23756 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id S261938AbTJMUVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 16:21:54 -0400
To: asdfd esadd <retu834@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts: common well-architected object model
References: <20031011183405.38980.qmail@web13007.mail.yahoo.com>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 13 Oct 2003 16:21:45 -0400
In-Reply-To: <20031011183405.38980.qmail@web13007.mail.yahoo.com>
Message-ID: <m31xtg3n3a.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

asdfd esadd <retu834@yahoo.com> writes:

> There is a connex, fork() might be a bad example,
> 
> it's simple - yes but 20 years have passed as Solaris
> is finding:
> 
> pid_t fork(void); vs. 
> 
> the next step in the evolution CreateProcess
> 
> BOOL CreateProcess(...)

 If you _really_ want this on Linux, then you can look in
/usr/include/spawn.h

 Of course, as with all of these ungeneric interfaces, it should
really be called spawn-of-satan.h

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
