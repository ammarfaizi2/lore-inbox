Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966631AbWKTUIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966631AbWKTUIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966627AbWKTUIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:08:48 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:28582 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S966626AbWKTUIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:08:47 -0500
Date: Mon, 20 Nov 2006 21:04:48 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Chris Snook <csnook@redhat.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       Jay Cliburn <jacliburn@bellsouth.net>, jeff@garzik.org,
       shemminger@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] atl1: Build files for Attansic L1 driver
Message-ID: <20061120200448.GA15720@electric-eye.fr.zoreil.com>
References: <20061119202915.GB29736@osprey.hogchain.net> <20061119152432.a85d4166.randy.dunlap@oracle.com> <456145DA.804@redhat.com> <4561CCA6.8080209@oracle.com> <4561D59F.5020206@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4561D59F.5020206@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Snook <csnook@redhat.com> :
[...]
> To be precise, mii-tool is deprecated, in favor of ethtool.  There are 

$ man mii-tool
[...]
       -v, --verbose
              Display  more  detailed  MII status information.  If used twice,
                                                                ^^^^^^^^^^^^^
              also display raw MII register contents.
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Is there a similar feature in ethtool ?

-- 
Ueimor
