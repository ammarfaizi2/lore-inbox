Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVCYJk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVCYJk6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 04:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVCYJk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 04:40:58 -0500
Received: from siaag2ab.compuserve.com ([149.174.40.132]:19898 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261567AbVCYJk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 04:40:56 -0500
Date: Fri, 25 Mar 2005 04:37:44 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: How's the nforce4 support in Linux?
To: Arjan van de Ven <arjan@infradead.org>
Cc: Asfand Yar Qazi <ay1204@qazi.f2s.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200503250440_MC3-1-99A2-B623@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005 at 10:34:12 +0100, Arjan van de Ven wrote:

> probably just one of those things implemented in the binary drivers in
> software, just like the "hardware" IDE raid is most of the time (3ware
> being the positive exception there)

 IT8212 is a real hardware ATA RAID controller.  Too bad it will never get
merged from -ac into mainline with the HW RAID support intact...

--
Chuck
http://www.counterfeitmini.org
