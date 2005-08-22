Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVHVT73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVHVT73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 15:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVHVT73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 15:59:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1730 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750783AbVHVT71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 15:59:27 -0400
Date: Mon, 22 Aug 2005 15:59:13 -0400
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, Mirko Lindner <mlindner@syskonnect.de>,
       akpm@osdl.org
Subject: Re: skge missing ifdefs.
Message-ID: <20050822195913.GF27344@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
	Mirko Lindner <mlindner@syskonnect.de>, akpm@osdl.org
References: <20050801203442.GD2473@redhat.com> <20050801203818.GA7497@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801203818.GA7497@havoc.gtf.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 04:38:18PM -0400, Jeff Garzik wrote:
 > On Mon, Aug 01, 2005 at 04:34:42PM -0400, Dave Jones wrote:
 > > with CONFIG_PM undefined, the build breaks due to 
 > > undefined symbols.
 > 
 > akpm already sent a fix to Linus.

This is still broken afaics in todays -git.

		Dave

