Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751660AbWHaPhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbWHaPhu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 11:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbWHaPhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 11:37:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33690 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751658AbWHaPht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 11:37:49 -0400
Subject: Re: libstdc++.so.5
From: Arjan van de Ven <arjan@infradead.org>
To: "Majumder, Rajib" <rajib.majumder@credit-suisse.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <F444CAE5E62A714C9F45AA292785BED30EB974E0@esng11p33001.sg.csfb.com>
References: <F444CAE5E62A714C9F45AA292785BED30EB974E0@esng11p33001.sg.csfb.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 31 Aug 2006 17:37:06 +0200
Message-Id: <1157038626.2715.129.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 23:09 +0800, Majumder, Rajib wrote:
> Hi,
> 
> I have 2 Linux boxes. 1 running RHEL 3,  2.4.21 kernel. Other SLSE 9, 2.6.5 kernel. 
> 
> While porting an C++ application from RHEL to SLES we faced some issue and it was resolved when we imported libstdc++.so.5 from RHEL and forced the app to reference this on SLES, rather than glibc (which was different ) in /usr/lib. We only ported 1 library.
> 
> In RHEL, gcc was 3.2.3, in SLES it was 3.3.2. 
> 
> Is there any risk associated with this?  

Hi,

this is clearly not a kernel question so you're asking on the wrong
list. A RHEL or SLES user list (as they are hosted by Novell / Red Hat)
would be a more appropriate venue, one also where it's more likely to
get a good answer..

Greetings,
   Arjan van de Ven

