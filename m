Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265500AbUFTO7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbUFTO7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 10:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265574AbUFTO7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 10:59:15 -0400
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:26546 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S265500AbUFTO7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 10:59:14 -0400
Message-ID: <40D5A642.6020901@backtobasicsmgmt.com>
Date: Sun, 20 Jun 2004 07:59:14 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.7 ACPI OOPS (random dereferrencing)
References: <Pine.LNX.4.60.0406180957470.977@hosting.rdsbv.ro> <1087571167.22483.20.camel@forum-beta.geizhals.at> <Pine.LNX.4.58.0406201340560.1998@kai.makisara.local>
In-Reply-To: <Pine.LNX.4.58.0406201340560.1998@kai.makisara.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Makisara wrote:

> The reports in the list above do not all point to similar symptoms. The 
> reports from Thomas, Kevin, Pozsar, and me seem to have two things in 
> common:
> - an Intel motherboard
> - hang when enabling ACPI

There is an entry in the RedHat Bugzilla where Len Brown is actively 
participating on this issue; he has been able to reproduce it (no 
surprise, he works for Intel and shouldn't have any trouble obtaining 
the same hardware <G>). There is no fix yet, though.
