Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVADP34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVADP34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 10:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVADP3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 10:29:55 -0500
Received: from [212.20.225.142] ([212.20.225.142]:46874 "EHLO
	orlando.wolfsonmicro.main") by vger.kernel.org with ESMTP
	id S261690AbVADP2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 10:28:48 -0500
Subject: Re: [PATCH 2/2] AC97 plugin suspend/resume
From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <41DAB13E.40208@didntduck.org>
References: <1104850247.9143.335.camel@cearnarfon>
	 <41DAB13E.40208@didntduck.org>
Content-Type: text/plain
Message-Id: <1104852526.9143.351.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 04 Jan 2005 15:28:46 +0000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jan 2005 15:28:47.0108 (UTC) FILETIME=[15519C40:01C4F272]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 15:07, Brian Gerst wrote:

> There is really no reason to add these fields if they are NULL.  Zero 
> (or NULL for pointers) is the default for all unspecified fields, and it 
> is kernel convention to use this feature to reduce clutter.
> 

Ok, patch 2/2 can be safely ignored. It was added for clarity.

Liam

