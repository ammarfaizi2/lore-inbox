Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWHXMsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWHXMsB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWHXMsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:48:01 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:16733 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751216AbWHXMsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:48:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=G85RpaZJqI7VcsFD55nJou2mAgEWKV+KhYBXydyGFC9S+tXIQiuLcqGRKw6eVAkJ4CD8ct0th741BfbnUnPMNXhO6PKJvvcLEjNdySm2D3nr+MuKRg4qTggg5lvmWyRzoEWY/mT/yNuiTdZ3nhhhfnA89O9KP9EATsBK3GwmAhw=
Message-ID: <292693080608240547w394bacc4l2410b6eba98d950b@mail.gmail.com>
Date: Thu, 24 Aug 2006 18:17:59 +0530
From: "Daniel Rodrick" <daniel.rodrick@gmail.com>
To: linux-kernel@vger.kernel.org, kernelnewbies <kernelnewbies@nl.linux.org>,
       linux-newbie@vget.kernel.org
Subject: Generic Disk Driver in Linux
Cc: satinder.jeet@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

I was curious that can we develop a generic disk driver that could
handle all the kinds of hard drives - IDE, SCSI, RAID et al?

I thought we could use the BIOS interrupt 13H for this purpose, but
ran into a LOT of real mode / protected mode issues.

Any other ideas?

Thanks,

Dan.
