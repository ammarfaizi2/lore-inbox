Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUAXVPp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 16:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbUAXVPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 16:15:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32228 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261909AbUAXVPm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 16:15:42 -0500
Message-ID: <4012E071.2080704@pobox.com>
Date: Sat, 24 Jan 2004 16:15:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: grundler@parisc-linux.org, jgarzik@redhat.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] 2.6.1 tg3 DMA engine test failure
References: <20040124013614.GB1310@colo.lackof.org>	<20040123.210023.74723544.davem@redhat.com>	<20040124073032.GA7265@colo.lackof.org> <20040123.233241.59493446.davem@redhat.com>
In-Reply-To: <20040123.233241.59493446.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

There were two separate components to Grant's patch (hint ggg... split 
up your patches).

What do you think about GRC-resets-sub-components part?

That appears valid (and probably wise) to me, but correct me if I'm wrong...

	Jeff




