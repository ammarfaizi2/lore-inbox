Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271233AbTHCVee (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271244AbTHCVee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:34:34 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:54681 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271233AbTHCVed
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:34:33 -0400
Subject: Re: issues with any ac sources, and 2.6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: bbeutner@comcast.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308032056.h73KuEem000277@81-2-122-30.bradfords.org.uk>
References: <200308032056.h73KuEem000277@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059946240.32022.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Aug 2003 22:30:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-03 at 21:56, John Bradford wrote:
> For the AC kernels, try backing out just the IDE patches, and see if
> that allows you to boot.

I dont think 2.6-ac has any IDE patches. Its a fair collection of driver
stuff so it could be hitting one of the driver things easily enough

