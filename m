Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbTLKShg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 13:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbTLKShg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 13:37:36 -0500
Received: from mail.webmaster.com ([216.152.64.131]:18140 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S265113AbTLKShc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 13:37:32 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Robin Rosenberg" <roro.l@dewire.com>, "Larry McVoy" <lm@bitmover.com>,
       "Kendall Bennett" <KendallB@scitechsoft.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux GPL and binary module exception clause?
Date: Thu, 11 Dec 2003 10:37:22 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEKNIKAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <200312111844.03839.roro.l@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If EXPORT_GPL is changed as a means of protecting the copyright,
> i..e. provide
> source code access. then doesn't this "mechanism" fall under the
> infamous DMCA,
> i.e. you're not allowed to even think about circumventing it...
>
> -- robin

	This was already discussed to death.

	If EXPORT_GPL were a copyright enforcement mechanism, it could not add any
restrictions not already present in the GPL because the GPL prohibits
additional restrictions. So either EXPORT_GPL is not a copyright enforcement
mechanism (in which case the DMCA doesn't prohibit removing or circumventing
it), or it only enforces technically restrictions that are already in effect
legally. So this would only matter to someone who said, "I'm going to
violate the GPL, what might happen?"

	Interestingly, even if it is a copyright enforcement mechanism and even if
it only enforces the GPL's actual terms, anyone who wants to could still
remove it. The inability to remove a copyright enforcement mechanism would
be an "additional restriction" and so it couldn't be imposed on a GPL'd
work. (IANAL, and you never know how courts would rule of course.)

	DS


