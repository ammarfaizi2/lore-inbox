Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313012AbSDGXl7>; Sun, 7 Apr 2002 19:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313329AbSDGXl6>; Sun, 7 Apr 2002 19:41:58 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:15374 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313012AbSDGXl5>;
	Sun, 7 Apr 2002 19:41:57 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Matt_Domsch@Dell.com
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre6 dead Makefile entries 
In-Reply-To: Your message of "Sun, 07 Apr 2002 12:52:50 EST."
             <71714C04806CD51193520090272892170452B5C0@ausxmrr502.us.dell.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Apr 2002 09:41:42 +1000
Message-ID: <30449.1018222902@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Apr 2002 12:52:50 -0500 , 
Matt_Domsch@Dell.com wrote:
>> >On Sun, Apr 07, 2002 at 09:01:39PM +1000, Keith Owens wrote:
>> >> lib/Makefile                    crc32.o

Forget crc32, the file is not referenced in base lib/Makefile.
Spurious bug report caused by another change.

