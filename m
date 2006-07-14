Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161076AbWGNL26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbWGNL26 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 07:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWGNL26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 07:28:58 -0400
Received: from aun.it.uu.se ([130.238.12.36]:26862 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932408AbWGNL25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 07:28:57 -0400
Date: Fri, 14 Jul 2006 13:28:45 +0200 (MEST)
Message-Id: <200607141128.k6EBSjDT014339@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: davem@davemloft.net, mikpe@it.uu.se
Subject: Re: 2.6.18-rc1 fails to boot on Ultra 5
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 16:04:01 -0700 (PDT), David Miller wrote:
>From: Mikael Pettersson <mikpe@it.uu.se>
>Date: Thu, 13 Jul 2006 14:18:33 +0200 (MEST)
>
>> No actual problems, but I noticed some differences in the
>> kernel log:
>
>This should take care of all 4 issues.  The typo in the sunsab
>driver causing the first port to not show up was good for a
>laugh. :)
>
>Let me know if it works for you too.

Works fine. The bug() is gone and I have both ttyS0 and ttyS1
again. Thanks.

(What I wrote previously about my Ultra5 only having one serial
port connector was wrong; I'm so used to DB9 connectors that I
mistook the DB25 connector for something else.)

/Mikael
