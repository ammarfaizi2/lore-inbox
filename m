Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272948AbTG3Q2Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 12:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272958AbTG3Q2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 12:28:16 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:4564 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S272948AbTG3Q2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 12:28:15 -0400
Date: Wed, 30 Jul 2003 09:27:46 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-mm1 results
Message-ID: <28310000.1059582465@[10.10.2.4]>
In-Reply-To: <200307310128.50189.kernel@kolivas.org>
References: <5110000.1059489420@[10.10.2.4]> <170360000.1059513518@flay> <17830000.1059577281@[10.10.2.4]> <200307310128.50189.kernel@kolivas.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 31 Jul 2003 01:01, Martin J. Bligh wrote:
>> OK, so test2-mm1 fixes the panic I was seeing in test1-mm1.
>> Only noticeable thing is that -mm tree is consistently a little slower
>> at kernbench
> 
> Could conceivably be my hacks throwing the cc cpu hogs onto the expired array 
> more frequently.

OK, do you have that against straight mainline? I can try it broken
out if so ...

M.

