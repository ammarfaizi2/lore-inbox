Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266152AbUBCVc5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 16:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUBCVc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 16:32:57 -0500
Received: from h24-76-142-122.wp.shawcable.net ([24.76.142.122]:47378 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S266152AbUBCVct convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 16:32:49 -0500
Date: Tue, 3 Feb 2004 15:33:24 -0600 (CST)
From: Derek Foreman <manmower@signalmarketing.com>
X-X-Sender: manmower@uberdeity
To: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>
cc: LINUX KERNEL MAILING LIST <linux-kernel@vger.kernel.org>, akpm@digeo.com
Subject: Re: Bug in mm series
In-Reply-To: <401F7D9B.3000706@wanadoo.es>
Message-ID: <Pine.LNX.4.58.0402031530510.438@uberdeity>
References: <401F7D9B.3000706@wanadoo.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004, [ISO-8859-1] Luis Miguel García wrote:

> When I try to boot with latest mm series (such as actual rc3-mm1 or
> rc2-mm2), my nforce ethernet device doesn't works. It worked in the past
> with the forcedeth reverse engineered driver but now it keeps for 30 or
> more seconds halted (at boot) and then the network device dosn't run.
>
> Here is the dmesg of rc3-mm1. Do you want for me to test something? Thanks!
>
> P.S.:   The ACPI related messages are larger that in rc3.

My e100 on an nforce2 won't work in rc3-mm1.
The "acpi=off" boot parameter makes it go.
