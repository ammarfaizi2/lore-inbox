Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbTFYWk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 18:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265142AbTFYWk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 18:40:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37249
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265141AbTFYWk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 18:40:26 -0400
Subject: Re: IDE Disk Driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: sumit_uconn@lycos.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <NOCKJMOAJLACOFAA@mailcity.com>
References: <NOCKJMOAJLACOFAA@mailcity.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056581498.2005.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Jun 2003 23:51:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-25 at 21:45, Sumit Narayan wrote:
> Hi,
> 
> Could I know if I could load a driver for a disk drive without rebooting the system? I have written a ide-disk driver, but I dont wish to restart the system. Can I simply load that module in some way, and then later return to the actual driver?

Not yet - I'm working in that direction

