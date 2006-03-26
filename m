Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWCZRHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWCZRHT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 12:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWCZRHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 12:07:18 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:64730 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S1751191AbWCZRHQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 12:07:16 -0500
Subject: Re: [Patch 8/9] generic netlink utility functions
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: balbir@in.ibm.com
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
In-Reply-To: <20060326164434.GC13362@in.ibm.com>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142297705.5858.28.camel@elinux04.optonline.net>
	 <20060326164434.GC13362@in.ibm.com>
Content-Type: text/plain
Organization: unknown
Date: Sun, 26 Mar 2006 12:06:57 -0500
Message-Id: <1143392817.5184.55.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-26-03 at 22:14 +0530, Balbir Singh wrote:

> Jamal,
> 
> Does the implementation of these utilities look ok? We use genlmsg_data()
> in the delay accounting code but not genlmsg_len(), hence it might not
> be very well tested (just reviewed).
> 

They look fine to me - please resubmit and CC Thomas Graf in case he
sees it different.

cheers,
jamal

