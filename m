Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265062AbUETMFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbUETMFV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 08:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265094AbUETMFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 08:05:20 -0400
Received: from ol.freeshell.org ([192.94.73.20]:51139 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S265062AbUETMFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 08:05:17 -0400
Date: Thu, 20 May 2004 12:05:15 +0000
From: john weber <weber@sixbit.org>
To: linux-kernel@vger.kernel.org
Subject: Performance Tuning
Message-ID: <20040520120514.GA29540@sixbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Organization: worldwideweber
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been comparing kernel compile stats online to those I get 
on my own machine, and I am baffled.

Kernel compiles take 6m38s on my P4 2.8GHz (with HT enabled) and 
512 MB RAM as compared to 20-30 seconds reported by folks online. 
I am running kernel 2.6.6.

While I understand that this varies with the config, I also don't 
see why it should vary so much.  Does anyone have any pointers on 
how I could best troubleshoot my performance?
