Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUFBL3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUFBL3U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 07:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUFBL3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 07:29:20 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:33002 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S261867AbUFBL3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 07:29:14 -0400
From: Manu Abraham <manu@kromtek.com>
Reply-To: manu@kromtek.com
Organization: Kromtek Systems
To: linux-kernel@vger.kernel.org
Subject: Minor numbers under 2.6
Date: Wed, 2 Jun 2004 15:19:32 +0400
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406021519.32128.manu@kromtek.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kromtek.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Can somebody clarify a question that i have ?

	Say under 2.4 kernel, char device drivers had a minor number of int. In the 
2.6 kernels, this number was increased to 20 bits from 8 bits. Under 2.6 i 
could use "mknod -c major, minor". 

	How can i achieve something similar with 2.6 taking into consideration that i 
have to create more than 255 minors ?


Regards,
Manu

