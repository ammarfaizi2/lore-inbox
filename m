Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbUFBMPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUFBMPW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUFBMPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:15:22 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:6016 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262476AbUFBMPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:15:12 -0400
Date: Wed, 2 Jun 2004 13:22:31 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200406021222.i52CMViE000156@81-2-122-30.bradfords.org.uk>
To: Con Kolivas <kernel@kolivas.org>, FabF <fabian.frederick@skynet.be>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200406022142.52854.kernel@kolivas.org>
References: <E1BVIVG-0003wL-00@calista.eckenfels.6bone.ka-ip.net>
 <1086154721.2275.2.camel@localhost.localdomain>
 <200406022142.52854.kernel@kolivas.org>
Subject: Re: why swap at all?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Con Kolivas <kernel@kolivas.org>:
> Does this explain in coarse examples to the desktop users why ideal systems 
> shouldn't be swap disabled or swappiness=0 ?

Yes, except in the case where you are processing a small, (relative to
physical RAM), dataset, and not even touching all physical RAM.

(I admit, this isn't really typical desktop usage, though).

John.
