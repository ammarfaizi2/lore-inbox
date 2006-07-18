Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWGRU7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWGRU7I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 16:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWGRU7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 16:59:08 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:28645 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S932396AbWGRU7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 16:59:07 -0400
Message-ID: <44BD4ADC.7040901@s5r6.in-berlin.de>
Date: Tue, 18 Jul 2006 22:55:56 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Thomas Dillig <tdillig@stanford.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Null dereference errors in the kernel
References: <44BC5A3F.2080005@stanford.edu>
In-Reply-To: <44BC5A3F.2080005@stanford.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Dillig wrote:
...
> We have identified around 300 potential issues related to null errors,
...

It would be nice if you split the reports according to subsystems and
send them to addresses (especially mailinglists) given in the
MAINTAINERS file in the base directory of the kernel sources.
-- 
Stefan Richter
-=====-=-==- -=== -====
http://arcgraph.de/sr/
