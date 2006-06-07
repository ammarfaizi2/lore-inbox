Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWFGX4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWFGX4o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 19:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWFGX4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 19:56:44 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:60123 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932468AbWFGX4n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 19:56:43 -0400
Date: Thu, 8 Jun 2006 01:56:31 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, netdev@vger.kernel.org,
       linux-xfs@oss.sgi.com, ecki@lina.inka.de, lkml@rtr.ca
Message-ID: <20060607235631.GA10688@linuxtv.org>
References: <20060607205316.bbb3c379.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060607205316.bbb3c379.diegocg@gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 84.189.224.177
Subject: Re: Updated sysctl documentation take #2
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006, Diego Calleja wrote:
> Since people didn't like the "many small files" approach, I've moved
> it to directories containing index.txt files:
> 
> Documentation/sysctl/vm/index.txt
> Documentation/sysctl/net/core/index.txt

Why not just

Documentation/sysctl/vm.txt
Documentation/sysctl/net/core.txt

etc.?


Johannes
