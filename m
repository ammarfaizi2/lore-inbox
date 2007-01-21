Return-Path: <linux-kernel-owner+w=401wt.eu-S1751719AbXAUWNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbXAUWNL (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 17:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbXAUWNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 17:13:11 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:4467 "EHLO
	mail1.webmaster.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbXAUWNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 17:13:10 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: KB->KiB, MB -> MiB, ... (IEC 60027-2)
Date: Sun, 21 Jan 2007 14:12:26 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKEENPBAAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-reply-to: <c384c5ea0701210904t15f44178hfd807b4553e0e3d3@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sun, 21 Jan 2007 15:14:57 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sun, 21 Jan 2007 15:14:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Talk about a cure worse than the disease! So you're
> > saying that 256MB flash
> > cards could be advertised as having 268.4MB? A 512MB RAM stick is
> > mislabelled and could correctly say 536.8MB? That's just plain
> > craziness.

> No, I meant to advertise it as a 256 MiB flash device and a 512 MiB
> flash device, as the Mi prefix has a single interpretation, that is 2
> to the power of 20, as per IEC 60027-2, whereas M has not if used
> outside SI units.

If it actually has 256*2^20 bytes, why advertise it as "256 MiB" when "268.4
MB" is equally valid and looks better? It really comes down to this: is it
your position that "256 MB" can only correctly mean 256 million bytes?

If you are right, a "512MB" RAM stick is mislabelled and is more correctly
labelled as "536.8MB". (With 512MiB being equally correct.)

Isn't that obviously not just wrong but borderline crazy? Yes, your position
has some nice consequences, but that doesn't allow you to ignore the bad
ones.

Unfortunately, we're not writing on a clean slate here.

DS


