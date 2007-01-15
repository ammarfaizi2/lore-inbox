Return-Path: <linux-kernel-owner+w=401wt.eu-S1751825AbXAOGcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbXAOGcA (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 01:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbXAOGb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 01:31:59 -0500
Received: from marisil.org ([72.9.228.73]:58509 "EHLO smtp.marisil.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824AbXAOGb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 01:31:58 -0500
X-Greylist: delayed 1789 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 01:31:58 EST
From: Peter Antoniac <antoniac@is.naist.jp>
Organization: NAIST
To: theSeinfeld@users.sourceforge.net
Subject: Re: allocation failed: out of vmalloc space error treating and VIDEO1394 IOC LISTEN CHANNEL =?iso-8859-1?q?ioctl=A0failed?= problem
Date: Mon, 15 Jan 2007 15:01:42 +0900
User-Agent: KMail/1.9.5
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       libdc1394-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net
References: <mailman.59.1168027378.1221.libdc1394-devel@lists.sourceforge.net> <tkrat.832df3763908c060@s5r6.in-berlin.de> <200701151314.11922.theSeinfeld@users.sf.net>
In-Reply-To: <200701151314.11922.theSeinfeld@users.sf.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701151501.42791.antoniac@is.naist.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 January 2007 13:14, Peter Antoniac wrote:
> This is more the answer that I expect. But is there a way, function or
> constant from **libdc** that can give you the answer, or you have to get it
...
What was I thinking... not from libdc but from LIBC :)
