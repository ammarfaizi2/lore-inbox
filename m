Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265524AbSJSF4U>; Sat, 19 Oct 2002 01:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265525AbSJSF4U>; Sat, 19 Oct 2002 01:56:20 -0400
Received: from web10504.mail.yahoo.com ([216.136.130.154]:9489 "HELO
	web10504.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265524AbSJSF4T>; Sat, 19 Oct 2002 01:56:19 -0400
Message-ID: <20021019060221.92006.qmail@web10504.mail.yahoo.com>
Date: Fri, 18 Oct 2002 23:02:21 -0700 (PDT)
From: Andy Tai <lichengtai@yahoo.com>
Reply-To: atai@atai.org
Subject: Re: Tigon3 driver problem with raw socket on 2.4.20-pre10-ac2
To: "David S. Miller" <davem@redhat.com>, atai@atai.org
Cc: linux-kernel@vger.kernel.org, greearb@candelatech.com
In-Reply-To: <20021017.231249.14334285.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your sugestion.  With Linux 2.4.19, the
problem goes away.  So something is wrong with the
2.4.20-pre kernels as related to the AMD Athlon...

Thanks again for your help.

Andy

--- "David S. Miller" <davem@redhat.com> wrote:
>    From: Andy Tai <lichengtai@yahoo.com>
>    Date: Thu, 17 Oct 2002 21:44:02 -0700 (PDT)
> 
>    Thus this indicates the problem is in the Tigon3
> driver.
> 
> Please retest with 2.4.19.
> 
> There have actually been a lot of Athlon based
> problem reports in the
> 2.4.20 series.  
> 


__________________________________________________
Do you Yahoo!?
Y! Web Hosting - Let the expert host your web site
http://webhosting.yahoo.com/
