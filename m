Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315296AbSEAFNC>; Wed, 1 May 2002 01:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315297AbSEAFNB>; Wed, 1 May 2002 01:13:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56588 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315296AbSEAFNB>;
	Wed, 1 May 2002 01:13:01 -0400
Message-ID: <3CCF796C.5090401@mandrakesoft.com>
Date: Wed, 01 May 2002 01:13:16 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Plan for e100-e1000 in mainline
In-Reply-To: <20020501010828.GA1753@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:

>Hi.
>
>Well, subject says it all. Which is the status/plans for inclussion
>of those drivers in mainline kernel ? AFAIR, e1000 had been licensed,
>but e100 was not clear yet.
>

e100 has been in 2.5.x for quite a long time.  All license issues have 
similarly been resolved a long time ago.

I expect Intel's Q/A to green light their current driver.  With a few 
patches it should be ready for 2.4.x soon.

You can easily copy drivers/net/e100[0] into a 2.4.x kernel, it likely 
compiles without modification.

    Jeff



