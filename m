Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271066AbTGPSds (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271065AbTGPSd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:33:27 -0400
Received: from unsol-intbg.internet-bg.net ([212.124.67.226]:31496 "HELO
	ns.unixsol.org") by vger.kernel.org with SMTP id S271060AbTGPScX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:32:23 -0400
Message-ID: <3F159DB2.90604@unixsol.org>
Date: Wed, 16 Jul 2003 21:47:14 +0300
From: Georgi Chorbadzhiyski <gf@unixsol.org>
Organization: Unix Solutions Ltd. (http://unixsol.org)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030514
X-Accept-Language: en, en-us, bg
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test1-mm1 success, tiny mouse and framebuffer problems
References: <3F156566.4040206@unixsol.org> <20030716172716.GA8030@kroah.com>
In-Reply-To: <20030716172716.GA8030@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Jul 16, 2003 at 05:47:02PM +0300, Georgi Chorbadzhiyski wrote:
> 
>>P.S. Every file in sysfs is 4096 bytes, is this normal?
> 
> And they _all_ aren't 4096 bytes, there are a few that report other
> sizes...

Probably equal to PAGE_SIZE ?

-
Georgi Chorbadzhiyski
http://georgi.unixsol.org/

