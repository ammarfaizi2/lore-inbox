Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUHAR1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUHAR1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 13:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUHAR1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 13:27:24 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:59048 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S263943AbUHAR1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 13:27:21 -0400
From: Daniel Phillips <phillips@istop.com>
To: "Walker, Bruce J" <bruce.walker@hp.com>
Subject: Re: [Linux-cluster] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
Date: Sun, 1 Aug 2004 13:30:01 -0400
User-Agent: KMail/1.6.2
Cc: "Discussion of clustering software components including GFS" 
	<linux-cluster@redhat.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <opengfs-devel@lists.sourceforge.net>,
       <opengfs-users@lists.sourceforge.net>,
       <opendlm-devel@lists.sourceforge.net>
References: <3689AF909D816446BA505D21F1461AE4C750E6@cacexc04.americas.cpqcorp.net>
In-Reply-To: <3689AF909D816446BA505D21F1461AE4C750E6@cacexc04.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408011330.01848.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 July 2004 12:00, Walker, Bruce J wrote:
> In the 2.4 implementation, providing this one capability by
> leveraging devfs was quite economic, efficient and has been very stable.

I wonder if device-mapper (slightly hacked) wouldn't be a better approach for 
2.6+.

Regards,

Daniel
