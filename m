Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTDQJue (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 05:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbTDQJud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 05:50:33 -0400
Received: from ANancy-107-1-10-87.abo.wanadoo.fr ([80.14.221.87]:12298 "EHLO
	xiii.freealter.fr") by vger.kernel.org with ESMTP id S261300AbTDQJud
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 05:50:33 -0400
Message-ID: <3E9E7B7C.9090605@freealter.com>
Date: Thu, 17 Apr 2003 12:01:32 +0200
From: Ludovic Drolez <ludovic.drolez@freealter.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ioctl to get partitions infos
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

As I need more than 'cat /proc/partitions', I wondered if there's an 
ioctl in 2.4 or 2.5 which will kindly return me all the information the 
kernel knows about partition (start sector, length, type) ? (pls, don't 
say that I need the parse the partition table myself ;-( )

Regards,

-- 
Ludovic DROLEZ                                       Free&ALter Soft
152, rue de Grigy - Technopole Metz 2000                  57070 METZ
tel : 03 87 75 55 21                            fax : 03 87 75 19 26

