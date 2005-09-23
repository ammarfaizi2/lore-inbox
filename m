Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVIWRIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVIWRIT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVIWRIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:08:18 -0400
Received: from iron.pdx.net ([207.149.241.18]:17547 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S1750803AbVIWRIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:08:18 -0400
Subject: Re: The system works (2.6.14-rc2): functional k8n-dl
From: Sean Bruno <sean.bruno@dsl-only.net>
To: karim@opersys.com
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, ak@suse.de,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <43332254.1040603@opersys.com>
References: <20050922155254.GE5910@us.ibm.com>
	 <43332254.1040603@opersys.com>
Content-Type: text/plain
Date: Fri, 23 Sep 2005 10:08:16 -0700
Message-Id: <1127495296.25701.15.camel@oscar>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-22 at 17:29 -0400, Karim Yaghmour wrote:
> Nish,
> 
> OK, I can confirm that with version 1006 of the BIOS it works flawlessly
> with Linux. I was able to install full FC4 and boot without a problem
> even with the SATA disk plugged to the nVidia controller (reading the
> archives you will see that the nVidia SATA controller is something I
> was simply unable to get working.) I didn't need to recompile anything.
> The kernel that came with FC4 worked just fine.
I can also confirm these findings.  However, I still have to boot the
kernel with iommu=memaper=3 in order to get the system to work
properly.  

Sean

