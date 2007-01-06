Return-Path: <linux-kernel-owner+w=401wt.eu-S932069AbXAFSuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbXAFSuU (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 13:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbXAFSuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 13:50:20 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:47984 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069AbXAFSuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 13:50:18 -0500
Date: Sun, 7 Jan 2007 03:49:02 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: David Brownell <david-b@pacbell.net>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>, lenehan@twibble.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       rtc-linux@googlegroups.com
Subject: Re: [patch 2.6.20-rc3] rtc-sh correctly reports rtc_wkalrm.enabled
Message-ID: <20070106184902.GA15144@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	David Brownell <david-b@pacbell.net>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	lenehan@twibble.org,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	rtc-linux@googlegroups.com
References: <200701052055.06264.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701052055.06264.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 08:55:05PM -0800, David Brownell wrote:
> This fixes the SH rtc driver to
>   (a) correctly report 'enabled' status with other alarm status;
>   (b) not duplicate that status in its procfs dump
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
Looks good, thanks David.

Acked-by: Paul Mundt <lethal@linux-sh.org>
