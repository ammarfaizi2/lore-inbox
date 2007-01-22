Return-Path: <linux-kernel-owner+w=401wt.eu-S1751902AbXAVDld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbXAVDld (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 22:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbXAVDld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 22:41:33 -0500
Received: from nz-out-0506.google.com ([64.233.162.230]:37766 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbXAVDld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 22:41:33 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=j1WDsiz3UiEcfOm57RN6O2NbSVXc13Ah7Q7aslmV9/cmoVZiO5hhY+jI6/C6v2oO/kVHgSBXZDe02nYdYr+cWetH2Snshq1NnUnh17icaQelCM5My5S2cCVJkoIkPZzdrfeUBygzU4ghya+xJ6C4Gznu0tv+dXN/owYhsYNMgIQ=
Message-ID: <45B43241.1070301@gmail.com>
Date: Mon, 22 Jan 2007 12:40:49 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: ris <ris@elsat.net.pl>
CC: Frederik Deweerdt <deweerdt@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: High CPU usage with sata_nv
References: <20070115164541.M22367@elsat.net.pl> <20070115165432.M87238@elsat.net.pl> <20070115182642.GA18374@slug> <20070115222320.M55059@elsat.net.pl>
In-Reply-To: <20070115222320.M55059@elsat.net.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ris wrote:
> and dmesg....

Please report...

1. 'vmstat 1' result during file copy (w/ cpu 100%)
2. 'dmesg' result after file copy

-- 
tejun
