Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130357AbRCBIuj>; Fri, 2 Mar 2001 03:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130368AbRCBIu2>; Fri, 2 Mar 2001 03:50:28 -0500
Received: from WARSL401PIP1.highway.telekom.at ([195.3.96.69]:3105 "HELO
	email01.aon.at") by vger.kernel.org with SMTP id <S130357AbRCBIuP>;
	Fri, 2 Mar 2001 03:50:15 -0500
Date: Fri, 2 Mar 2001 09:48:54 +0100
From: Eduard Hasenleithner <eduardh@aon.at>
To: linux-kernel@vger.kernel.org
Subject: Re: How to set hdparms for ide-scsi devices on devfs?
Message-ID: <20010302094854.A19782@moserv.hasi>
Mail-Followup-To: Eduard Hasenleithner <eduardh@aon.at>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010228224850.A10608@moserv.hasi> <Pine.LNX.4.10.10103010310070.6914-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10103010310070.6914-100000@master.linux-ide.org>; from andre@linux-ide.org on Thu, Mar 01, 2001 at 03:10:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 03:10:53AM -0800, Andre Hedrick wrote:
> 
> procfs
> 
> echo unmaskirq:1 /proc/ide/hdx/settings
> 

Thank you, thats perfect. Is setting the parameters a relatively
new feature? I searched for a possibiliy like this and found no
references.

PS: Is there still a possibility for setting the IDE-sleep timeout
	for a ide-scsi harddisk?  (I know, this doesnt make sense)
-- 
Eduard Hasenleithner
student of
Salzburg University of Applied Sciences and Technologies
