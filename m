Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWDSStk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWDSStk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWDSStk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:49:40 -0400
Received: from cpe-66-66-109-154.rochester.res.rr.com ([66.66.109.154]:46742
	"EHLO death.krwtech.com") by vger.kernel.org with ESMTP
	id S1751147AbWDSStj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:49:39 -0400
Date: Wed, 19 Apr 2006 14:49:37 -0400 (EDT)
From: Ken Witherow <ken@krwtech.com>
X-X-Sender: ken@death
Reply-To: Ken Witherow <ken@krwtech.com>
To: linux-kernel@vger.kernel.org
Subject: Advansys SCSI driver and 2.6.16
Message-ID: <Pine.LNX.4.64.0604191444200.1841@death>
Organization: KRW Technologies
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use an Advansys controller for an old, slow SCSI drive and my flatbed 
scanner. I noticed that upon trying to boot 2.6.16, my Advansys controller 
wasn't detected. Further investigation shows that the driver has been 
fairly silently disappearing over the last couple releases.

Is this a permanent change or is the Advansys driver just in need of some 
updating to current APIs? I'd hate to have to replace this controller and 
I don't want to be stuck at 2.6.15 forever. If someone could point me in 
the right direction about what the problem is, I'd be glad to take a look 
at seeing if I could fix it.

-- 
        Ken Witherow <phantoml AT rochester.rr.com>
            ICQ: 21840670  AIM: phantomlordken
                http://www.krwtech.com/ken

