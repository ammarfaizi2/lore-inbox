Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423921AbWKABUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423921AbWKABUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423919AbWKABUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:20:21 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:28627 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1423918AbWKABUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:20:19 -0500
Message-ID: <4547F646.2080000@garzik.org>
Date: Tue, 31 Oct 2006 20:20:06 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Jan-Bernd Themann <ossthema@de.ibm.com>
CC: netdev <netdev@vger.kernel.org>, Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [PATCH 2.6.19-rc3 1/2] ehea: kzalloc GFP_ATOMIC fix
References: <200610251311.43009.ossthema@de.ibm.com>
In-Reply-To: <200610251311.43009.ossthema@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Bernd Themann wrote:
> This patch fixes kzalloc parameters (GFP_ATOMIC instead of GFP_KERNEL)
> 
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>

applied to #upstream-fixes

In the future, please include a description of -why- patches like this 
are needed (I got the info from your replies in this case)


