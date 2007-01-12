Return-Path: <linux-kernel-owner+w=401wt.eu-S1751290AbXALNKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbXALNKy (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 08:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbXALNKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 08:10:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:17802 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbXALNKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 08:10:53 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wv7fzbAzeC9jVldfsKH6v8v/YkUmSBB9vFI6X1ArYX4+4E1hY1heyY+y+Xmw//mWyTwZjwNELSJr5FS1LJE9sqXBUDQMRUJAdz0k10DoswYyz4ehi6PhzDTH8WuSeEI4zD5eEaEwLJE+I4b3SzWDTysMUudSzhcKChhU06XMUy4=
Message-ID: <6bffcb0e0701120510w13295ab6scbdff1be3cb5ab1@mail.gmail.com>
Date: Fri, 12 Jan 2007 14:10:50 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Jiri Slaby" <jirislaby@gmail.com>
Subject: Re: 2.6.20-rc4-mm1strange bug
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <45A77FCF.2010107@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bffcb0e0701120338j399461fdna6984bce16ae4622@mail.gmail.com>
	 <45A77FCF.2010107@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/07, Jiri Slaby <jirislaby@gmail.com> wrote:
> Michal Piotrowski wrote:
> > Hi,
> >
> > This bug looks strange
> > http://www.stardust.webpages.pl/files/tbf/euridica/2.6.20-rc4-mm1/bug.jpg
> > http://www.stardust.webpages.pl/files/tbf/euridica/2.6.20-rc4-mm1/mm-config
>
> Here too, see
> http://lkml.org/lkml/2007/1/12/45

Thanks. Now it almost works ;).

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
