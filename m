Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVAaWpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVAaWpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVAaWpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:45:22 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:32449 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261413AbVAaWpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:45:18 -0500
Date: Mon, 31 Jan 2005 16:45:05 -0600 (CST)
From: Pat Gefre <pfg@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Patrick Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org, matthew@wil.cx,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] Altix : ioc4 serial driver support
In-Reply-To: <20050103140938.GA20070@infradead.org>
Message-ID: <Pine.SGI.3.96.1050131164059.62785B-100000@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've updated this patch with suggestions from the reviews. And moved it
up the latest 2.6 (since it has been awhile...). I'm also adding
Bartlomiej as a CC since there are IDE mods involved.


The code is at:
ftp://oss.sgi.com/projects/sn2/sn2-update/033-ioc4-support

Signed-off-by: Patrick Gefre <pfg@sgi.com>



