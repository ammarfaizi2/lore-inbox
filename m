Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVHAUmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVHAUmE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVHAUja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:39:30 -0400
Received: from havoc.gtf.org ([69.61.125.42]:32175 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261253AbVHAUiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:38:19 -0400
Date: Mon, 1 Aug 2005 16:38:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Mirko Lindner <mlindner@syskonnect.de>
Cc: akpm@osdl.org
Subject: Re: skge missing ifdefs.
Message-ID: <20050801203818.GA7497@havoc.gtf.org>
References: <20050801203442.GD2473@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801203442.GD2473@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 04:34:42PM -0400, Dave Jones wrote:
> with CONFIG_PM undefined, the build breaks due to 
> undefined symbols.

akpm already sent a fix to Linus.

	Jeff



