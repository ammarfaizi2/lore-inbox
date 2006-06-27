Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWF0TGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWF0TGB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWF0TGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:06:01 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:20370 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932534AbWF0TGA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:06:00 -0400
Message-ID: <44A181A1.3090801@drzeus.cx>
Date: Tue, 27 Jun 2006 21:06:09 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/21] Series short description
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, could you have a look and this and queue it in -mm (so that it
can be included in 2.6.18)? Russell is busy with other responsibilities
and I don't want to miss this merge window.

Pierre Ossman wrote:
> The SD Association decided to release a specification for the SDHCI
> controllers. This set of patches updates the current driver, which is
> based on reverse engineering, to comply with the official specification.
> 
> It has been tested for quite some time by people on the sdhci-devel list.
> Although it doesn't solve all known issues, it doesn't cause any new ones.

Rgds
Pierre
