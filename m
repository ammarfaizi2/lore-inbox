Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbUKRBKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbUKRBKL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 20:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbUKRBJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 20:09:37 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:56592 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S262673AbUKRBEh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 20:04:37 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Cc: <clemens@endorphin.org>
Subject: RE: GPL version, "at your option"?
Date: Wed, 17 Nov 2004 17:04:28 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEOHPNAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1100614115.16127.16.camel@ghanima>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 17 Nov 2004 16:40:55 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 17 Nov 2004 16:40:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As the text says, the licensee can choose the GPL version at his option,
> and he is likely to choose the one with better conditions. So, newer
> version can never limit the licensee's right, because he is always free
> to choose version 2. Therefore, successor versions can only remove
> limitations.

	Your logic is totally flawed. Successor versions can certainly add
limitations.

	Consider the following hypothetical, GPL version 3 allows you to relicense
the code under the FreeBSD license. Someone relicenses Linux (with lots of
later modification) under the FreeBSD license. Now people who receive the
binaries from this new stream of Linux are not entitled to the source code.

	Not that this would ever happen, of course, but if your question is, "what
possible harm could it do", the answer is that new limitations could be put
in the newer licenses and newer code could be released with only the new
license.

	When Linux opted to apply the GPL to early versions of Linux, he wasn't
concerned only with protecting that code as it existed at that instant. He
was creating the framework that shapes the future development of Linux into
the future. The "at your option" clause could be used to transfer that
contorl to the FSF.

	Suppose GPL version 3 has no requirement that you make the source
available. I can then ship Linux without making any source available at all
by claiming that I'm using that later version at my option.

	DS


