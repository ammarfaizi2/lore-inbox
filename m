Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVFORYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVFORYs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 13:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVFORXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 13:23:19 -0400
Received: from mxsf11.cluster1.charter.net ([209.225.28.211]:22990 "EHLO
	mxsf11.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261237AbVFORUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 13:20:21 -0400
X-IronPort-AV: i="3.93,201,1115006400"; 
   d="scan'208"; a="1184450307:sNHT18003156"
Subject: Re: via-rhine broken in 2.6.12-rc6 and 2.6.11 stable
From: Avery Fay <avery@ravencode.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1118854779.3107.7.camel@localhost.localdomain>
References: <1118854779.3107.7.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 15 Jun 2005 13:20:16 -0400
Message-Id: <1118856017.2987.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nevermind about the stable kernel part. For some reason, my symbolic
links were not getting updated right. But it definitely doesn't work on
2.6.12-rc6 and it's definitely related to vmware. Is this something that
vmware needs to fix?

On Wed, 2005-06-15 at 12:59 -0400, Avery Fay wrote:
> Hello,
> 
> I just upgraded to the latest Debian release of 2.6.11. via-rhine
> breaks. I also tried 2.6.12-rc6 and it's broken too. A few notes:
> 
> 1.) this is an Averatec 3225hs laptop
> 2.) I'm using vmware too w/vmnet module
> 3.) Worked on previous 2.6.11 debian releases
> 4.) when i bring this interface up, i'm also enabling nat

-- 
Avery Fay <avery@ravencode.com>
