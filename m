Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbVK3XzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVK3XzS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVK3XzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:55:18 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:47789 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751274AbVK3XzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:55:16 -0500
Message-ID: <438E3B33.2030807@jp.fujitsu.com>
Date: Thu, 01 Dec 2005 08:52:19 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: akpm@osdl.org, lhms-devel@lists.sourceforge.net,
       Cliff Wickman <cpw@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Direct Migration V6: Overview
References: <20051130171056.19405.95644.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051130171056.19405.95644.sendpatchset@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

> Changes V5->V6:
> - Patchset against 2.6.15-rc3-mm1
> - Remove checks for page count increases while migrating after Andrew assured

Could you point where is changed in the code ?

>   me that this cannot happen. Revise documentation to reflect that. If this is
>   the case then we will have no need to include the unwind code from the
>   hotplug project in the future.

-- Kame

