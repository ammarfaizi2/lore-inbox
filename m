Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264604AbUAMSYw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 13:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUAMSWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 13:22:45 -0500
Received: from h-68-164-243-10.SNVACAID.covad.net ([68.164.243.10]:55170 "EHLO
	mail.cryptobackpack.org") by vger.kernel.org with ESMTP
	id S264604AbUAMSWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 13:22:08 -0500
Date: Tue, 13 Jan 2004 10:21:54 -0800
From: mutex <mutex@cryptobackpack.org>
To: Scott Long <scott_long@adaptec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Proposed enhancements to MD
Message-ID: <20040113182154.GH7303@heliosphan.in.cryptobackpack.org>
Reply-To: mutex <mutex@cryptobackpack.org>
References: <40033D02.8000207@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40033D02.8000207@adaptec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 05:34:10PM -0700 or thereabouts, Scott Long wrote:
> All,
> 
> Adaptec has been looking at the MD driver for a foundation for their
> Open-Source software RAID stack.  This will help us provide full
> and open support for current and future Adaptec RAID products (as
> opposed to the limited support through closed drivers that we have now).
> 
> While MD is fairly functional and clean, there are a number of 
> enhancements to it that we have been working on for a while and would
> like to push out to the community for review and integration.  These
> include:
> 


How about a endian safe superblock ?  Seriously, is that a 'bug' or a
'feature' ?  Or do people just not care.
