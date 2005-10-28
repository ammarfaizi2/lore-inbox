Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbVJ1Frb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbVJ1Frb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 01:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbVJ1Frb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 01:47:31 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:59268 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S965103AbVJ1Fra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 01:47:30 -0400
Date: Fri, 28 Oct 2005 07:47:23 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NPTL support for 2.4.31?
Message-ID: <20051028054723.GA32148@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Harald Dunkel <harald.dunkel@t-online.de>,
	linux-kernel@vger.kernel.org
References: <4361B55C.7000705@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4361B55C.7000705@t-online.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 07:21:32AM +0200, Harald Dunkel wrote:

> Is there some module/patch for kernel 2.4.31 available to
> support NPTL? I know that there is a backport in RH's 2.4.21,
> but obviously it didn't make it into the native 2.4 kernel.

I doubt anybody else would do the work, you'll find that any NPTL patch is
bound to be huge and intrusive. Try running 2.6 if possible. A 2.4 kernel
with NPTL patched in is not going to confer any stability benefits over 2.6.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
