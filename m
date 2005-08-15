Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVHOGB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVHOGB6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 02:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVHOGB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 02:01:58 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:18670 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932077AbVHOGB5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 02:01:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nW4ivcuOFBS4Zp9z1LMd5S/Nus/DXZRlg3DvyZtF1w5brWz9qiFv1iyq/YPuA1XIeMO1coMKZIYljJWm5VjL/821xUSA7C5mfWs9qX3aO6ho88W8EQ9cXT52ZDGJ2X7acL5lVZFEqhCeBi8PVeW6dWgA1ugL2c3o6Lld1bQe0Ic=
Message-ID: <add7e60b050814230176b3fd02@mail.gmail.com>
Date: Mon, 15 Aug 2005 14:01:52 +0800
From: Christopher Chan <feizhou.asia@gmail.com>
To: Allen Martin <AMartin@nvidia.com>
Subject: Re: NCQ support NVidia NForce4 (CK804) SATAII
Cc: Michael Thonke <iogl64nx@gmail.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B004FAE3E7@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <DBFABB80F7FD3143A911F9E6CFD477B004FAE3E7@hqemmail02.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Likely the only way nForce4 NCQ support could be added under Linux would
> be with a closed source binary driver, and no one really wants that,
> especially for storage / boot volume.  We decided it wasn't worth the
> headache of a binary driver for this one feature.  Future nForce
> chipsets will have a redesigned SATA controller where we can be more
> open about documenting it.

This one feature can make a big difference to whether your higher end
NForce Professional chips will even be considered for low/mid range
servers. Now that some NCQ support is starting to appear in libata,
people will be looking to elsewhere for motherboards that offer NCQ
support under Linux. If Nvidia had provided a binary driver, who knows
how many would now be using boxes that have NForce Professional chips?
