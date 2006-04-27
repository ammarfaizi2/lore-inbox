Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbWD0V1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWD0V1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 17:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbWD0V1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 17:27:25 -0400
Received: from main.gmane.org ([80.91.229.2]:47557 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751685AbWD0V1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 17:27:24 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Heiko J Schick <info@schihei.de>
Subject: Re: [PATCH 01/16] ehca: integration in Linux kernel	build system
Date: Thu, 27 Apr 2006 23:26:59 +0200
Message-ID: <e2rcv0$920$1@sea.gmane.org>
References: <4450B384.4020601@de.ibm.com> <200604271307.36987.arnd.bergmann@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p50814d44.dip.t-dialin.net
User-Agent: Unison/1.7.5
Cc: linuxppc-dev@ozlabs.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-04-27 13:07:36 +0200, Arnd Bergmann <arnd.bergmann@de.ibm.com> said:

> It would be more practical to put this patch last instead of
> first so you don't break the build system with partial applies.

I agree. I Will change set for the next patchset.


