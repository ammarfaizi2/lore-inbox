Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751682AbWJELaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWJELaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 07:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWJELaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 07:30:20 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:35550 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750749AbWJELaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 07:30:19 -0400
Message-ID: <4524ECC6.2060201@garzik.org>
Date: Thu, 05 Oct 2006 07:30:14 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jan-Bernd Themann <ossthema@de.ibm.com>
CC: netdev <netdev@vger.kernel.org>, Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [PATCH 2.6.19-rc1] ehea bug fix (port state notification, default
 queue sizes)
References: <200609281244.40887.ossthema@de.ibm.com>
In-Reply-To: <200609281244.40887.ossthema@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

which patch is to be applied first?

You failed to include an order, as described by 
http://linux.yyz.us/patch-format.html and Documentation/SubmittingPatches.

Also, stuff like "hi Jeff" and "Thanks, Jan-Bernd" must be hand-edited 
out before patch application.  All comments not intended to be DIRECTLY 
copied into the kernel changeset description should follow the "---" 
separator.

	Jeff



