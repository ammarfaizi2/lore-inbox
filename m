Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbUBXRB4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbUBXRBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:01:48 -0500
Received: from smtp14.fre.skanova.net ([195.67.227.31]:46301 "EHLO
	smtp14.fre.skanova.net") by vger.kernel.org with ESMTP
	id S262296AbUBXRBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:01:43 -0500
Cc: linux-kernel@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Promise SATA driver
References: <200402241110.07526.andrew@walrond.org> <20040224154446.GA28720@ee.oulu.fi> <403B73E3.80100@pobox.com> <200402241630.36105.andrew@walrond.org> <403B8028.1060700@pobox.com>
Message-ID: <opr3vv7qk4uwbm4s@localhost>
From: Henrik Gustafsson <henrik.gustafsson@fnord.se>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Tue, 24 Feb 2004 18:00:52 +0100
In-Reply-To: <403B8028.1060700@pobox.com>
User-Agent: Opera7.20/Win32 M2 build 3144
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004 11:47:36 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:

> Andrew Walrond wrote:
>> I take it the software raid thing wasn't part of the gpl'ed driver, and 
>> isn't something that is likely to happen?
>
>
> In 2.4, RAID0 and RAID1 are supported via the pdcraid driver.
>
> In 2.6, Promise software RAID support does not exist.  In conversations 
> with Promise, we all agreed to encourage and support the standard Linux 
> RAID, md.
>
> 	Jeff

Does that apply to the FastTrack S150 SX4 aswell? The hardware XOR-engine 
will not be used?
What about the onboard cache?

// Henrik Gustafsson
