Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264656AbRFPVEI>; Sat, 16 Jun 2001 17:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbRFPVD6>; Sat, 16 Jun 2001 17:03:58 -0400
Received: from [200.255.3.159] ([200.255.3.159]:1284 "EHLO
	olimpo.networx.com.br") by vger.kernel.org with ESMTP
	id <S264656AbRFPVDt> convert rfc822-to-8bit; Sat, 16 Jun 2001 17:03:49 -0400
Message-Id: <200106172246.SAA00859@olimpo.networx.com.br>
Content-Type: text/plain; charset=US-ASCII
From: Thiago Vinhas de Moraes <tvlists@networx.com.br>
Organization: Networx - A SuaCompanhia.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.5-ac14
Date: Sat, 16 Jun 2001 17:56:08 -0300
X-Mailer: KMail [version 1.2.2]
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <E15B0vv-000780-00@the-village.bc.nu>
In-Reply-To: <E15B0vv-000780-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sex 15 Jun 2001 18:15, Alan Cox escreveu:
> > Why the 2.4.5-ac series doesn't have merges from Linus 2.4.6-pre anymore?
>
> Because right now I dont consider the 2.4.6 page cache ext2 stuff safe
> enough to merge. I'm letting someone else be the sucide squad.. so far it
> looks like it is indeed fine but I want to wait and see more yet

But wouldn't be safe/possible/viable to merge 2.4.6-pre partially, excluding 
the page cache stuff for the moment?
IMHO, the 2.4.6-pre has important improvements, and it would be difficult to 
merge to it later.
Just a stupid opinion. No offenses.

Regards,
-- 
________________________________
 Thiago Vinhas de Moraes
 NetWorx - A SuaCompanhia.com
