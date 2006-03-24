Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422758AbWCXHxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422758AbWCXHxQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 02:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422763AbWCXHxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 02:53:16 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:25100 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S1422758AbWCXHxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 02:53:15 -0500
Date: Fri, 24 Mar 2006 18:52:45 +1100
From: CaT <cat@zip.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, arjan@infradead.org,
       yang.y.yi@gmail.com, linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru,
       matthltc@us.ibm.com
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector v3
Message-ID: <20060324075245.GY2057@zip.com.au>
References: <1143183541.2882.7.camel@laptopd505.fenrus.org> <20060323.230649.11516073.davem@davemloft.net> <20060323232345.1ca16f3f.akpm@osdl.org> <20060323.232903.34304885.davem@davemloft.net> <20060323234200.19e7eb54.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323234200.19e7eb54.akpm@osdl.org>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 11:42:00PM -0800, Andrew Morton wrote:
> You explained why it was better than grafting audit onto this application. 
> 
> But do you see some special value in the actual services which this patch
> provides - monitoring filesystem events?

Is there something around atm that would, for example, allow a virus
scanner to scan files when they are created, etc? Or to add files to
an index for quick searches?

There are probably other potential uses but I'm too tired and those two
come to mind right now.

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
