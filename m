Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVC3WYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVC3WYt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 17:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbVC3WYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 17:24:49 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:4148 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262458AbVC3WYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 17:24:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=RFaHAcpQDIwp+8sAu8QaDMFC6e8cCftZwucwjcclRwyp+WwH7ST2/38ony7CV1RTSXHhmSXWwjqKE3wXWuPCmgD7Gjov8BvEa7Rt0055pxNJeflqSMOIBBuvGnaBLos9IkrOG/GZ6JMD0wlYwINAiO2FpkfmRDZ1KODIQXIYn/s=
Message-ID: <a728f9f90503301424138e2bb6@mail.gmail.com>
Date: Wed, 30 Mar 2005 17:24:30 -0500
From: Alex Deucher <alexdeucher@gmail.com>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Marvell 88W8310 (libertas) 802.11g support
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was just wondering if anyone has started working on a driver for the
marvell wifi chips.  I just bought a new Asus motherboard and it has
built in wifi.  I contacted Marvell and they claimed they could
provide databooks under NDA.  If no one else is working on it, I may
try my hand at it, although I must say I've never written a network
driver.  Is anyone else planning support/working on a driver/etc.?

Thanks,

Alex

PS please cc: me on any replies.
