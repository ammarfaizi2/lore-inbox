Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265204AbSJaHWc>; Thu, 31 Oct 2002 02:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265208AbSJaHWc>; Thu, 31 Oct 2002 02:22:32 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:29654 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S265204AbSJaHWb>; Thu, 31 Oct 2002 02:22:31 -0500
Message-ID: <3DC0DA57.7040900@drugphish.ch>
Date: Thu, 31 Oct 2002 08:23:03 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: wolk-devel@lists.sourceforge.net, wolk-announce@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] v2.2.22-2-secure // [PATCH | PATCHSET | FULLKERNEL]
References: <200210310057.24743.m.c.p@wolk-project.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


> Changes in v2.2.22-1-secure
> ---------------------------
> o  add:      Port/Socket Pseudo ACLs v2.2.21-14
> o  add:      VM buffer tuning
> o  add:      Etherdivert
> o  add:      802.1d Ethernet Bridging v1.02
> o  add:      Firewall for the ethernet bridge, using ipchains v1.02
> o  add:      IPsec masquerading with IPVS

How can you have such a code in the 2.2.x kernel when we're not even 
finished with its 2.5.x implementation in LVS? If you took the code from 
ipvs-1.1.0 and backported it, I would believe it, but I doubt this is 
possible. Care to clarify this entry?

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

