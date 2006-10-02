Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWJBDcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWJBDcL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 23:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWJBDcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 23:32:11 -0400
Received: from quechua.inka.de ([193.197.184.2]:37099 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751341AbWJBDcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 23:32:10 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Smaller compressed kernel source tarballs?
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20061002033511.GB12695@zimmer>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1GUEXH-00008o-00@calista.eckenfels.net>
Date: Mon, 02 Oct 2006 05:32:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20061002033511.GB12695@zimmer> you wrote:
> The pace of compression algorithm development is high enough that I'd
> suggest that the bar be placed quite high before switching to a new
> compression format that's not reverse compatible.
> 
> For those interested, I'm working on publishing a proof of concept that 
> can make most tarballs compress better. About 2-3% better in my tests 
> with bzip2/gzip on the Linux kernel source code.

3% is not a high bar.

Gruss
Bernd
