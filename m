Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161298AbWI2Dbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161298AbWI2Dbn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 23:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161302AbWI2Dbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 23:31:43 -0400
Received: from mail1.webmaster.com ([216.152.64.169]:58384 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1161298AbWI2Dbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 23:31:42 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <B.Steinbrink@gmx.de>, "Neil Brown" <neilb@suse.de>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: GPLv3 Position Statement
Date: Thu, 28 Sep 2006 20:31:07 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKCENMOLAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20060929030518.GA21048@atjola.homenet>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 28 Sep 2006 20:34:04 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 28 Sep 2006 20:34:05 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It's in section 1, where it says "keep intact all the notices that refer
> to this License" (section 2 refers to section 1).
> The current GPLv3 draft says (section 4): "keep intact all license
> notices".
>
> Notice a difference? I'm not a native speaker and of course IANAL, but
> AFAICT, with "v2 or later", if you follow the terms of GPLv2, you are
> only required to keep notices refering to THAT license, ie. GPLv2, so
> you seem to be allowed to remove the GPLv3 notices. But if you follow
> the terms of the GPLv3, you are required to keep ALL license notices,
> including those that refer to v2.
> So you could actually never ever make a "v2 or later" program a
> "v3 only" program, but only a "v2 only".
>
> Am I missing something?

That section uses the phrase "this license" twice. I think it's only
reasonable to assume it means the same thing in both places. It says you
must "give any other recipients of the Program a copy of this License along
with the Program".

If "this license" means GPLv2, then the GPLv2 does not allow you to remove
the GPLv2 notice. I think it's somewhat absurd to say that you must include
a copy of the license but may take away their right to use the code under
that license.

If "this license" means "whatever license you happen to have to this
program", then you cannot remove or modify *any* license notices, including
the "GPLv2 or later at your option" notice.

I see no plausible way to argue that GPLv2 permits you to change "GPLv2 or
later at your option" to "GPLv3 or later at your option". If GPLv3 does not
either, then you may not do so.

DS


