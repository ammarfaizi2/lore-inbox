Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVAXKYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVAXKYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 05:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVAXKYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 05:24:40 -0500
Received: from ns1.q-leap.de ([153.94.51.193]:45501 "EHLO mail.q-leap.de")
	by vger.kernel.org with ESMTP id S261478AbVAXKYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 05:24:34 -0500
Message-ID: <41F4CCE0.5010709@q-leap.com>
Date: Mon, 24 Jan 2005 11:24:32 +0100
From: Peter Kruse <pk@q-leap.com>
Organization: Q-Leap Networks GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en
MIME-Version: 1.0
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Random packets loss under x86_64 - routing?
References: <41E7E6D7.10303@q-leap.com> <Pine.LNX.4.61.0501141129260.5840@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0501141129260.5840@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> 
> The fact that `ping -r` works seems to show that the ARP table
> has stale entries in it.
> 
> 

The problem is gone with 2.6.10.  We can live with this solution.

Thanks,

	Peter

-- 
Peter Kruse <pk@q-leap.com>, Chief Software Architect
Q-Leap Networks GmbH
phone: +497071-703171, mobile: +49172-6340044
