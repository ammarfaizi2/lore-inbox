Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264846AbTFQUWZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264837AbTFQUWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:22:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25746 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264828AbTFQUWU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:22:20 -0400
Message-ID: <3EEF7BB3.9050700@pobox.com>
Date: Tue, 17 Jun 2003 16:36:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Linux NICS <linux.nics@intel.com>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: Linux 2.5.72: ixgb_ethtool: strange SUPPORTED_10000baseT_Full
References: <20030617203407.GC29247@fs.tum.de>
In-Reply-To: <20030617203407.GC29247@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The correct solution seems to be to remove the #define from 
> ixgb_ethtool.c ?


correct.

wanna send a patch?  ;-)

	Jeff



