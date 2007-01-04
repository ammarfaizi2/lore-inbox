Return-Path: <linux-kernel-owner+w=401wt.eu-S1750979AbXADB50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbXADB50 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 20:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbXADB5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 20:57:25 -0500
Received: from alnrmhc11.comcast.net ([204.127.225.91]:38764 "EHLO
	alnrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbXADB5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 20:57:25 -0500
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 20:57:25 EST
Message-ID: <459C5D6C.5010509@comcast.net>
Date: Wed, 03 Jan 2007 20:50:36 -0500
From: Ed Sweetman <safemode2@comcast.net>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: S.M.A.R.T no longer available in 2.6.20-rc2-mm2 with libata
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure what went on between 2.6.19-rc5-mm2 and 2.6.20-rc2-mm2 in 
libata land but SMART is no longer available on my hdds.   I'm assuming 
this is not the intended behavior. 

In case this is chipset specific, IDE interface: nVidia Corporation 
CK804 Serial ATA Controller (rev f3)

I'm using Libata nvidia driver, the drives happen to be sata drives, but 
even the pata ones no longer report having SMART. 


