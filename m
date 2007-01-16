Return-Path: <linux-kernel-owner+w=401wt.eu-S1751954AbXAQAIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbXAQAIP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 19:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbXAQAIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 19:08:15 -0500
Received: from avexch1.qlogic.com ([198.70.193.115]:46834 "EHLO
	avexch1.qlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbXAQAIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 19:08:14 -0500
X-Greylist: delayed 849 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 19:08:14 EST
Date: Tue, 16 Jan 2007 15:54:13 -0800
From: Ravi Anand <ravi.anand@qlogic.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: David Somayajulu <david.somayajulu@qlogic.com>,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] drivers/scsi/qla4xxx/: possible cleanups
Message-ID: <20070116235413.GA17703@ranandlinuxbox.qlogic.org>
References: <20070114134554.GW7469@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070114134554.GW7469@stusta.de>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 16 Jan 2007 23:54:04.0479 (UTC) FILETIME=[9A63CCF0:01C739C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sun, 14 Jan 2007, Adrian Bunk wrote:

> Date: Sun, 14 Jan 2007 14:45:54 +0100
> From: Adrian Bunk <bunk@stusta.de>
> To: Ravi Anand <ravi.anand@qlogic.com>,
> 	David Somayajulu <david.somayajulu@qlogic.com>
> Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
> 	linux-kernel@vger.kernel.org
> Subject: [RFC: 2.6 patch] drivers/scsi/qla4xxx/: possible cleanups
> User-Agent: Mutt/1.5.13 (2006-08-11)
> 
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - #if 0 unused functions

Ack. 

Thanx
Ravi Anand
