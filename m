Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268082AbUBRVD7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 16:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268091AbUBRVD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 16:03:59 -0500
Received: from pop.gmx.de ([213.165.64.20]:8875 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268082AbUBRVD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 16:03:56 -0500
X-Authenticated: #20450766
Date: Wed, 18 Feb 2004 22:03:03 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Brad Cramer <bcramer@callahanfuneralhome.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: sym53c8xx_2 driver and tekram dc-390u2w kernel-2.6.x
In-Reply-To: <00c301c3f62d$ae3e8540$6501a8c0@office>
Message-ID: <Pine.LNX.4.44.0402182202150.5836-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004, Brad Cramer wrote:

> Yes that is my drive, but after it scans the scsi bus and finds all the
> devices it will not mount any of the partitions. And I know it is not
> corrupted partitions because they mount fine under 2.4.18 using the
> sym53c8xx driver.
> I don't have the exact message in front of me, but when I try to manually
> mount the partitions under 2.6.2 I get errors something about parity errors,
> again I could get the exact message when I get home tonight.

That might give a clue.

Guennadi
---
Guennadi Liakhovetski


