Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317695AbSGOXor>; Mon, 15 Jul 2002 19:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317696AbSGOXoq>; Mon, 15 Jul 2002 19:44:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45060 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317695AbSGOXop>; Mon, 15 Jul 2002 19:44:45 -0400
Message-ID: <3D335F04.6070700@zytor.com>
Date: Mon, 15 Jul 2002 16:47:16 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc1-ac5
References: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com>	<20020715220241Z317668-	 685+9887@vger.kernel.org> 	<agvl00$jjm$1@cesium.transmeta.com>	<1026779299.32689.46.camel@irongate.swansea.linux.org.uk> 	<3D335903.6000603@zytor.com> <1026775760.1093.508.camel@sinai>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Mon, 2002-07-15 at 16:21, H. Peter Anvin wrote:
> 
> 
>>Hmmm...
>>
>>This bothers me somewhat, because a .bz2 file should not have been
>>created if the .gz file was corrupt, but the original poster strongly
>>implied that he had both the .gz file and a .bz2 file, unless your
>>update came in between.
> 
> 
> No, I think the bzip2 was not created while the gzip file was corrupt.
> 
> Earlier, there was a corrupt gzip and no bzip2 file.
> 
> Then I guess Alan fixed it, and now there exists both a valid gzip and
> bzip2 file.  So I think your stuff is working fine :)
> 

Right, misunderstanding cleared up.

By the way, these things really should go to the kernel/patch author,
not to the list.

	-hpa


