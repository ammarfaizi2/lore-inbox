Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbTFEXM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 19:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbTFEXM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 19:12:59 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:33603 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S265252AbTFEXM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 19:12:58 -0400
Date: Fri, 6 Jun 2003 00:26:25 +0100 (BST)
From: David Anderson <dave@halogensunlight.co.uk>
To: linux-kernel@vger.kernel.org
Subject: hpt374 driver question
Message-ID: <Pine.LNX.4.21.0306060020160.18421-100000@zion.matrix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 05 Jun 2003 23:26:30.0510 (UTC) FILETIME=[E4DC68E0:01C32BB9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've finally manage to get my onboard hpt374 controller recognized under
2.5.70. The controller and drives(hdi & hdk) are correctly reported at
boot time but I can't work out how to access the RAID array. I've tried
things like /dev/sdx and dev/ataraid with no luck. Can anyone tell me how
to access the RAID array?

Apologies for the simplicity of this question but I've spent all day at it
and haven't been able to find any relavent docs.

Thanks,

David Anderson

