Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751699AbWD0VkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWD0VkF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 17:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWD0VkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 17:40:04 -0400
Received: from main.gmane.org ([80.91.229.2]:19435 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751699AbWD0VkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 17:40:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Heiko J Schick <info@schihei.de>
Subject: Re: [PATCH 06/16] ehca: common include files
Date: Thu, 27 Apr 2006 23:31:41 +0200
Message-ID: <e2rd7t$94v$1@sea.gmane.org>
References: <4450A183.6030405@de.ibm.com> <200604271319.06844.arnd.bergmann@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p50814d44.dip.t-dialin.net
User-Agent: Unison/1.7.5
Cc: openib-general@openib.org, linuxppc-dev@ozlabs.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-04-27 13:19:06 +0200, Arnd Bergmann <arnd.bergmann@de.ibm.com> said:

> Well, you should also remove this for submission, I guess ;-)

Yeah, I've planed to remove this lines when 2.6.17 official came out.
It is still included because we don't want to introduce unnecessary
dependencies.

I will remove it for the next patchset.

Regards,
	Heiko


