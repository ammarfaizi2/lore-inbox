Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265681AbUFDJb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbUFDJb0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUFDJb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:31:26 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2176 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265681AbUFDJbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:31:20 -0400
Date: Fri, 4 Jun 2004 10:38:54 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200406040938.i549csmc000161@81-2-122-30.bradfords.org.uk>
To: Daniel Egger <de@axiros.com>, Rick Jansen <rick@rockingstone.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F1C736B7-B605-11D8-B781-000A958E35DC@axiros.com>
References: <20040604075448.GK18885@web1.rockingstone.nl>
 <F1C736B7-B605-11D8-B781-000A958E35DC@axiros.com>
Subject: Re: DriveReady SeekComplete Error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Daniel Egger <de@axiros.com>:
> Seems so, try getting the SMART utils and have a look at the
> output of smartctl -a <device>.
> 
> However I fail to see why this l-k related and as such offtopic
> here.

1. I see no particular evidence to suggest that the drive is necessarily faulty.
2. It is on topic because it may well be a coding error in the kernel.

John.
