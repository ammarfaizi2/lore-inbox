Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131162AbRAJKMT>; Wed, 10 Jan 2001 05:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131934AbRAJKMA>; Wed, 10 Jan 2001 05:12:00 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:27841 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131162AbRAJKLy>; Wed, 10 Jan 2001 05:11:54 -0500
Message-ID: <3A5C3701.DB2C5C08@uow.edu.au>
Date: Wed, 10 Jan 2001 21:18:41 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Stéphane Borel <stef@via.ecp.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: IBM Netfinity with 2.4.0
In-Reply-To: <20010110024744.A26255@via.ecp.fr> <3A5C2142.C119CE7C@uow.edu.au>,
		<3A5C2142.C119CE7C@uow.edu.au>; from andrewm@uow.edu.au on Wed, Jan 10, 2001 at 07:45:54PM +1100 <20010110105750.B29666@via.ecp.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stéphane Borel" wrote:
> 
>...
> The network adapter found is an onboard chip ; we also have a 3com 3c980
> and an atm adapter in the server, which give the following lines with
> 2.2.18 :

Could you please send the output of `lspci -vx' under kernel 2.4?

What happens when you run `modprobe 3c59x'?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
