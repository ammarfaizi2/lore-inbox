Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbQKGVoy>; Tue, 7 Nov 2000 16:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129722AbQKGVoo>; Tue, 7 Nov 2000 16:44:44 -0500
Received: from 213-123-76-7.btconnect.com ([213.123.76.7]:61059 "EHLO
	saturn.homenet") by vger.kernel.org with ESMTP id <S129699AbQKGVoe>;
	Tue, 7 Nov 2000 16:44:34 -0500
Date: Tue, 7 Nov 2000 21:39:20 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Anil kumar <anils_r@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <20001107205233.13661.qmail@web6102.mail.yahoo.com>
Message-ID: <Pine.LNX.4.21.0011072137120.3574-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Anil kumar wrote:
>   The system hangs after messages:
>   loading linux......
>   uncompressing linux, booting linux kernel OK.
> 
>   The System hangs here.
> 
>   Please let me know where I am wrong

Hi Anil,

The only serious mistake you did was using test9 kernel when test11-pre1
(or at least test10) was available. So, redo everything you have done with
test11-pre1 and if you still cannot boot then send a message to this list
with details like your CPUs, motherboard etc. etc.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
