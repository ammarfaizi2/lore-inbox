Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVC2XmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVC2XmP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 18:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVC2XmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 18:42:15 -0500
Received: from gate.crashing.org ([63.228.1.57]:484 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261649AbVC2XmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 18:42:08 -0500
Subject: Re: mac53c94 driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <4249CB23.6030203@hypersurf.com>
References: <4249CB23.6030203@hypersurf.com>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 09:41:05 +1000
Message-Id: <1112139665.31848.68.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 13:39 -0800, Kevin Diggs wrote:
> Hi,
> 
> 	I am not subscribed so please CC me personally.
> 
> 	Anyone know where I might find a programming manual for the NCR 53C94? 
> Also any details about the Grand Central dma thing would be appreciated. 
> Finally, if there is a more targeted list for this driver, please point 
> me to it. Thanks!

Google for "MacTech.pdf" and you may find this old "Macintosh Technology
for CHRP" document that documents the DBDMA engine (beware of the bugs).
Also, earlier Darwin's used to have a driver for the 53c94 that you may
want to look at too (check out opendarwin.org for old stuff).

Ben.


