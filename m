Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbVKDWfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVKDWfb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVKDWfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:35:31 -0500
Received: from outbound01.telus.net ([199.185.220.220]:19332 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S1751081AbVKDWfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:35:30 -0500
From: Andi Kleen <ak@suse.de>
To: Tim Bird <tim.bird@am.sony.com>
Subject: Re: New (now current development process)
Date: Fri, 4 Nov 2005 23:35:20 +0100
User-Agent: KMail/1.8
Cc: Linus Torvalds <torvalds@osdl.org>, Roland Dreier <rolandd@cisco.com>,
       Andrew Morton <akpm@osdl.org>, zippel@linux-m68k.org,
       rmk+lkml@arm.linux.org.uk, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <Pine.LNX.4.64.0511012203370.27915@g5.osdl.org> <436BDBCF.6070008@am.sony.com>
In-Reply-To: <436BDBCF.6070008@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511042335.21781.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 November 2005 23:08, Tim Bird wrote:
> starting in about April of next year.

Any particular reason it's taking so long? Would it perhaps be possible
to do a subset (e.g. only a single architecture and less configs) sooner?
If the problem is writing the necessary scripts, I'm sure some people
(e.g. M. Bligh or Al Viro) have already written some that do
at least the automated building and would be happy to
share them.

-Andi
