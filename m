Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbVIADh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbVIADh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 23:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVIADh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 23:37:27 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:16333 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S965068AbVIADh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 23:37:26 -0400
Subject: Re: APs from the Kernel Summit run Linux
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Mark Lord <mlord@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <94E48213-4A1A-4979-B3A7-05E7BBE19AD3@mac.com>
References: <20050830093715.GA9781@midnight.suse.cz>
	 <4315E0F0.6060209@pobox.com> <20050831205319.A6385@flint.arm.linux.org.uk>
	 <20050831203211.GA13752@midnight.suse.cz>
	 <94E48213-4A1A-4979-B3A7-05E7BBE19AD3@mac.com>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1125545767.12996.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 01 Sep 2005 13:36:07 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-09-01 at 13:29, Kyle Moffett wrote:
> The 4020 and 0402 look oddly symmetrical to me, but that could just
> be my imagination.

All I saw in it was byte n+1 = byte n >> 1. Can't see any use to that
either, though. Maybe it's just there to torment reverse engineerers, or
trap memory corruption?

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

