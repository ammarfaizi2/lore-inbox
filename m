Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313366AbSDLHTF>; Fri, 12 Apr 2002 03:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313412AbSDLHTD>; Fri, 12 Apr 2002 03:19:03 -0400
Received: from violet.setuza.cz ([194.149.118.97]:22800 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S313366AbSDLHTB>;
	Fri, 12 Apr 2002 03:19:01 -0400
Subject: Re: /dev/zero
From: Frank Schaefer <frank.schafer@setuza.cz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <F19vSvGLmUwJ21DnxDD00014fbb@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 12 Apr 2002 09:19:02 +0200
Message-Id: <1018595942.2918.2.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-04-12 at 08:46, blesson paul wrote:
> Hi all
>                I am newbie to linux kernel. What is the use of /dev/zero. 
> Why it is created and how to use it
> regards
> Blesson Paul
> 
> 
> 
> _________________________________________________________________
> Chat with friends online, try MSN Messenger: http://messenger.msn.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
Hi,

/dev/zero is a data source. It delivers zeroes ( maybe that's why this
name ;-).

BTW: You are new to the linux kernel or new to linux / unix?

Regards
Frank

