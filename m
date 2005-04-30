Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVD3Vr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVD3Vr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 17:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVD3Vr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 17:47:29 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:2987 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261439AbVD3Vr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 17:47:27 -0400
Date: Sat, 30 Apr 2005 23:41:24 +0200
From: bert hubert <ahu@ds9a.nl>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: possibly bogus AMD64 MCE reporting.
Message-ID: <20050430214124.GA9321@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andy Lutomirski <luto@myrealbox.com>, linux-kernel@vger.kernel.org
References: <4273E7B1.6020500@myrealbox.com> <20050430203723.GA8122@outpost.ds9a.nl> <4273F24C.3040202@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4273F24C.3040202@myrealbox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 02:02:04PM -0700, Andy Lutomirski wrote:

> Anything I should attach to provide more info?
> 
> I just upgraded to mcelog-0.4, but at this rate I don't expect a new 
> dump for awhile.

I'll investigate the MCE reports from my opteron machine in the coming days
and report back if they are bogus as well

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
