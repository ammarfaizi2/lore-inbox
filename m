Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316018AbSEJPNQ>; Fri, 10 May 2002 11:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316019AbSEJPNQ>; Fri, 10 May 2002 11:13:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8712 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316018AbSEJPNO>;
	Fri, 10 May 2002 11:13:14 -0400
Message-ID: <3CDBE34A.8050806@mandrakesoft.com>
Date: Fri, 10 May 2002 11:12:10 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: chen_xiangping@emc.com, linux-kernel@vger.kernel.org
Subject: Re: Tcp/ip offload card driver
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F553D1A42@srgraham.eng.emc.com> <20020510.074343.35536226.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>   From: "chen, xiangping" <chen_xiangping@emc.com>
>   Date: Fri, 10 May 2002 10:48:23 -0400
>
>   Is there any TCP offload (TOE) card driver available on Linux?
>   
>Why do you want it?  There is no proven performance benefit.
>
>PCI bandwidth is the limiting factor for networking performance.
>


Linux TCP implementation will always be more powerful and more flexible 
than any NIC, too.  I doubt they have netlink and netfilter on NICs, for 
example :)

    Jeff



