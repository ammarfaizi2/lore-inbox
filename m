Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbULJVfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbULJVfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbULJVek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:34:40 -0500
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:30187 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261821AbULJVeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:34:12 -0500
Message-ID: <41BA1684.2010109@mech.kuleuven.ac.be>
Date: Fri, 10 Dec 2004 22:35:00 +0100
From: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XGI Volari XP5 PCI device ID
References: <41BA0B77.9000902@mech.kuleuven.ac.be> <20041210212831.GB6648@redhat.com>
In-Reply-To: <20041210212831.GB6648@redhat.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Fri, Dec 10, 2004 at 09:47:51PM +0100, Panagiotis Issaris wrote:
> 
> > Some Dell Inspiron 5160s are now shipped with a
> > XGI Volari XP5. The card's PCI vendor identifier
> > is 1023, which represents Trident. XGI bought Trident
> > in june 2003.
> > 
> > This trivial patch adds the PCI device ID to the database.
>
>The correct way is to add it to the database at http://pciids.sf.net
>which gets periodically synced with the kernel.
>This way, your addition automatically finds its way
>into pciutils and any other userspace tools using that database.
>  
>
My apologies; I've added it the correct way now.

Thanks,
Takis

-- 
------------------------------------------------------------------------
Panagiotis Issaris
Katholieke Universiteit Leuven
Division Production Engineering,
Machine Design and Automation
Celestijnenlaan 300B              panagiotis.issaris@mech.kuleuven.ac.be
B-3001 Leuven Belgium                 http://www.mech.kuleuven.ac.be/pma
------------------------------------------------------------------------

