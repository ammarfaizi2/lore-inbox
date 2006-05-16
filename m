Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWEPDnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWEPDnF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 23:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWEPDnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 23:43:04 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:51725 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751109AbWEPDnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 23:43:02 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Subject: RE: GPL and NON GPL version modules
Date: Mon, 15 May 2006 20:42:12 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKCEPGLOAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <AF63F67E8D577C4390B25443CBE3B9F7092952@esnmail.esntechnologies.co.in>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 15 May 2006 20:37:59 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Mon, 15 May 2006 20:38:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 1. I developed a code which interfaces well with a proprietary OS. Now,
> somebody else feels to use the same module in his Linux Kernel. So, he
> comes up with a patch, which interfaces and talks to my module with my
> interfaces and then makes a release with the patch. And, I would have no
> idea of my module being really compatible/used in Linux Kernel. One fine
> day, I would get a mail saying that I need to make my code open source.
> What would be my reply?

	When you say "makes a release with the patch", what are you talking about?
A release of what? It sounds like all you need to do is include a note in
your license that you prohibit combining your code with GPL'd code and
distributing the result. Talk to a lawyer about the right wording, but you
want to impose complying with any GPL obligations on the person who chooses
to combine your code with GPL'd code. Then it's not your problem.

	However, I don't see how it's your problem anyway. This sounds way outside
the scope of the GPL or any copyright license. Since your module is not a
derivative work of any GPL'd work, it should be well outside the scope of
the GPL. Nothing anyone else can do could change the status of your work.

	DS


