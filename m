Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVC2TAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVC2TAn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 14:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVC2TAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 14:00:42 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:58634 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261297AbVC2TAe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 14:00:34 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <mrmacman_g4@mac.com>
Cc: "Wichert Akkerman" <wichert@wiggy.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Sean" <seanlkml@sympatico.ca>,
       "Mark Fortescue" <mark@mtfhpc.demon.co.uk>
Subject: RE: Can't use SYSFS for "Proprietry" driver modules !!!.
Date: Tue, 29 Mar 2005 11:00:30 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEIHCMAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <be1ed86fc663c1a441ab51ea3d6fd4fe@mac.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Tue, 29 Mar 2005 10:59:45 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Tue, 29 Mar 2005 10:59:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 28, 2005, at 20:53, David Schwartz wrote:

> > The GPL explicitly permits you to modify the code as you wish, and this
> > includes removing any restriction or enforcement type code.

> Yeah, sure, one could remove the technological enforcement, but IIRC the
> thread also brought up that you _still_ couldn't distribute anything
> that
> _used_ the broken type enforcement, because changing the source code to
> include the comment "This is Public Domain!" likewise doesn't make it
> so.

	The GPL specifically permits unrestricted functional modification and
distribution. So you cannot violate the GPL by modifying and distributing
the resulting modifications (except perhaps by altering or removing the text
of the GPL itself).

	The GPL contains no technical restrictions or software enforcement
mechanisms. While you could add some to GPL'd software, you could not
prohibit their removal. That would be an "additional restriction", which the
GPL forbids.

	Since the GPL permits their removal, removing them cannot be circumventing
the GPL. Since the GPL is the only license and the license permits you to
remove them, they cannot be a license enforcement mechanism. How can you
enforce a license that permits unrestricted functional modification?

	Perhaps you could make an argument if the code only restricted things
specifically prohibited by the GPL. But the GPL also permits unrestricted
usage, so it's not clear how this could happen.

	DS


