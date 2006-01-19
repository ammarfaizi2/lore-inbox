Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161073AbWASSJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbWASSJH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbWASSJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:09:07 -0500
Received: from gate.in-addr.de ([212.8.193.158]:54664 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1161073AbWASSJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:09:06 -0500
Date: Thu, 19 Jan 2006 19:07:48 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Phillip Susi <psusi@cfl.rr.com>, govind raj <agovinda04@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID 5+0 support
Message-ID: <20060119180748.GX10884@marowsky-bree.de>
References: <BAY109-F267E92D32B75385FDB680DD61C0@phx.gbl> <43CFCBB2.3050003@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43CFCBB2.3050003@cfl.rr.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-01-19T12:26:10, Phillip Susi <psusi@cfl.rr.com> wrote:

> Why on earth would you want to stripe two raid-5's instead of using one 
> raid-5 that is twice as big?  You'd get more usable disk space that way. 

If redundancy is the goal - to be able to withstand two drive failures
-, RAID6 would be the considerably better choice.


Sincerely,
    Lars Marowsky-Brée

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

