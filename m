Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269384AbUJSNOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269384AbUJSNOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 09:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269390AbUJSNOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 09:14:52 -0400
Received: from smtp09.auna.com ([62.81.186.19]:51665 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S269384AbUJSNOv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 09:14:51 -0400
Date: Tue, 19 Oct 2004 13:14:38 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Timeout problems with ATA/SATA
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <1098190711l.7834l.0l@werewolf.able.es>
In-Reply-To: <1098190711l.7834l.0l@werewolf.able.es> (from
	jamagallon@able.es on Tue Oct 19 14:58:31 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1098191678l.11789l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.19, J.A. Magallon wrote:
> Hi all...
> 
> I'm getting some proeblems and hangs with latest kernels.
> I have two kind of problems, with ATA and with SATA-RAID.
> SATA disks ata1-8 are part of a raid5 array exported via samba
> (two promise controlers, 3 out of 4 ports used on each).
> hde is an ATA disk for system root.
> 
> hde gives errors with 2.6.9 and -rc4-mm1. Also ata5 (SATA).
> 2.6.9-rc3-mm3 is working fine.
> 
> With 2.6.9-rc4-mm1, I get this messages:
> 

Ahh. forgot to say that system gets locked after that,
sometimes just samba hangs, others the box is completely dead...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc4-mm1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #4


