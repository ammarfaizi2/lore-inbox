Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316067AbSEJQ7y>; Fri, 10 May 2002 12:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316069AbSEJQ7x>; Fri, 10 May 2002 12:59:53 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:8034 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S316067AbSEJQ7w>; Fri, 10 May 2002 12:59:52 -0400
Date: Fri, 10 May 2002 11:59:49 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200205101659.LAA30191@tomcat.admin.navo.hpc.mil>
To: davem@redhat.com, pmanuel@myrealbox.com
Subject: Re: Tcp/ip offload card driver
In-Reply-To: <20020510.080405.124002004.davem@redhat.com>
Cc: chen_xiangping@emc.com, linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com>:
>    From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
>    Date: Fri, 10 May 2002 17:11:55 +0200
> 
>       Actually there is. Think iSCSI. Have a look at this article at 
>    LinuxJournal - http://linuxjournal.com/article.php?sid=4896 .
> 
> The Linux networking stack need have no hand in any of the IPv4 done
> by iSCSI, it can live entirely in the cards firmware and Linux need
> not know what the transport looks like at all.
> -

Depends on what kind of authentication you also need. I haven't seen anything
on that. So far as I know (and that is limited right now) iSCSI doesn't
perform any kind of authentication beyond IP number.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
