Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317711AbSHHVKd>; Thu, 8 Aug 2002 17:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317986AbSHHVKd>; Thu, 8 Aug 2002 17:10:33 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:43504 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317711AbSHHVKc>; Thu, 8 Aug 2002 17:10:32 -0400
Subject: Re: What patches I need for s stable 2.5.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brad Chapman <jabiru_croc@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020808210231.42461.qmail@web40007.mail.yahoo.com>
References: <20020808210231.42461.qmail@web40007.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 08 Aug 2002 23:34:20 +0100
Message-Id: <1028846060.28882.105.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 22:02, Brad Chapman wrote:
> Everyone,
> 
>       I have been following some of the threads on linux-kernel and have read
> about the IDE problems. I know about Jens' 2.4.x IDE foreport, and I was 
> wondering: what other patches should I apply, besides the 2.4.x IDE foreport,
> to ensure a stable 2.5.x kernel?

The IDE stuff might get you a usable 2.5, even then the error handling
is not correct in all cases so treat it with care. On my test boxes the
foreport didnt hang the machine the way 2.5.* did so its an improvement.
You might just want to follow the 2.5.*-dj tree though

