Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316017AbSEJPMk>; Fri, 10 May 2002 11:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316018AbSEJPMj>; Fri, 10 May 2002 11:12:39 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:18639 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S316017AbSEJPMh>; Fri, 10 May 2002 11:12:37 -0400
From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
To: chen_xiangping@emc.com, "David S. Miller" <davem@redhat.com>
Date: Fri, 10 May 2002 17:11:55 +0200
MIME-Version: 1.0
Subject: Re: Tcp/ip offload card driver
CC: linux-kernel@vger.kernel.org
Message-ID: <3CDBFF5B.32550.1364FB2@localhost>
In-Reply-To: <20020510.074343.35536226.davem@redhat.com>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Actually there is. Think iSCSI. Have a look at this article at 
LinuxJournal - http://linuxjournal.com/article.php?sid=4896 .


/Pedro

On 10 May 2002 at 7:43, David S. Miller wrote:

>    From: "chen, xiangping" <chen_xiangping@emc.com>
>    Date: Fri, 10 May 2002 10:48:23 -0400
> 
>    Is there any TCP offload (TOE) card driver available on Linux?
> 
> Why do you want it?  There is no proven performance benefit.
> 
> PCI bandwidth is the limiting factor for networking performance.
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


