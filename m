Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268538AbUHLMm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268538AbUHLMm6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 08:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268537AbUHLMm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 08:42:58 -0400
Received: from main.gmane.org ([80.91.224.249]:64746 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268542AbUHLMkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 08:40:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: Linux SATA RAID FAQ
Date: Thu, 12 Aug 2004 14:17:13 +0300
Message-ID: <pan.2004.08.12.11.17.12.443916@yahoo.com>
References: <411B0F45.8070500@pobox.com> <20040812.7181062@knigge.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: home-33027.b.astral.ro
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Cc: linux-ide@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004 07:18:10 +0000, Michael Knigge wrote:
> I don't care about RAID, but could you tell which S-ATA 
> Controller/Chipset is the best for Hot-Swap?

Hi Michael,

I think 3ware is the most stable right now, and has his own separate
driver. It is even seen as a SCSI controller by linux, but has SATA or
PATA disks.
Maybe there are some others, but I heard this is stable right now, and
hot-swapping is working on it.

