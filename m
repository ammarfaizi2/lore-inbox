Return-Path: <linux-kernel-owner+w=401wt.eu-S965021AbWL1Wcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWL1Wcw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 17:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWL1Wcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 17:32:52 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:3472 "EHLO
	mail1.webmaster.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965021AbWL1Wcv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 17:32:51 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "LKML" <linux-kernel@vger.kernel.org>
Subject: RE: Binary Drivers
Date: Thu, 28 Dec 2006 14:32:21 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEPHAJAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <45938788.4010201@kanardia.eu>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 28 Dec 2006 15:35:06 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 28 Dec 2006 15:35:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Do we have a right to reverse engineer hardware, or they are protected by
> patents or something similar that would prevent you from 
> publishing results
> adn/or drivers (open source).

As I understand the issues, you have the right to reverse engineer hardware except where the DMCA applies. I don't see any way a patent or similar could prevent you from publishing results. Again, the DMCA might.
 
> Are there any restrictions in how you obtain information - signal 
> analyser,
> disassembly of windows driver, etc.

There are a few things that might be able to impose such a restriction on you. If none of these apply, I think you should be okay: Any EULA, shrink-wrap, or click-through type agreement that might apply to the software (whether the driver, OS, analyzer, or whatever). Also, any actual agreement you entered into.

Patents don't provide any ability to keep things secret. Copyright doesn't apply to a creative work you made yourself, even if it describes the creative work of another in *functional* detail.

IANAL, and I might have missed something. IMO, the DMCA or a driver EULA are the only things you really need to worry about. It's hard to see how the DMCA would apply if we're not talking about some kind of content protection scheme.

DS


