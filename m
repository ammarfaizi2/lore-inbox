Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWETABu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWETABu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 20:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWETABu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 20:01:50 -0400
Received: from cantor2.suse.de ([195.135.220.15]:40110 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751437AbWETABt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 20:01:49 -0400
From: Andi Kleen <ak@suse.de>
To: Brice Goglin <brice@myri.com>
Subject: Re: [PATCH 3/4] myri10ge - Driver core
Date: Sat, 20 May 2006 02:01:43 +0200
User-Agent: KMail/1.9.1
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, gallatin@myri.com,
       linux-kernel@vger.kernel.org
References: <20060517220218.GA13411@myri.com> <200605180108.32949.arnd@arndb.de> <446E51AB.9080703@myri.com>
In-Reply-To: <446E51AB.9080703@myri.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605200201.43462.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We have tried :) But there is no nice way to split this code. So I guess
> we will have to keep it like this.

You could shorten the #define names a bit (s/MYRI10GE_MCP_ETHER_/MCP_/)  Then everything 
will fit better.

-Andi
