Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbVLFSm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbVLFSm2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVLFSm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:42:28 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:39387 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965009AbVLFSm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:42:26 -0500
Subject: Re: copy_from_user/copy_to_user question
From: Steven Rostedt <rostedt@goodmis.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Vinay Venkataraghavan <raghavanvinay@yahoo.com>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0512061314560.5396@chaos.analogic.com>
References: <20051206175301.34596.qmail@web32110.mail.mud.yahoo.com>
	 <Pine.LNX.4.61.0512061314560.5396@chaos.analogic.com>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 13:42:20 -0500
Message-Id: <1133894540.6724.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 13:23 -0500, linux-os (Dick Johnson) wrote:

> 
> (note)__assess__ means even "peek at".
> 
> FYI, there should never even be such a question.

Dick, be nice.  I get the impression that Vinay is just looking at some
code that he can't disclose because of some policy of the company he
works for.  He's curiously looking at the code of some non-mainstream
driver (either GPL or some NDA version) and is questioning what he sees.
Not everyone that does this is a kernel hacker.  This is the way I
started, and these questions, which may seem so obvious to a veteran
kernel hacker, is not so to a novice.

-- Steve


