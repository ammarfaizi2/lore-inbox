Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129697AbQKXWqM>; Fri, 24 Nov 2000 17:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129703AbQKXWqC>; Fri, 24 Nov 2000 17:46:02 -0500
Received: from falcon.prod.itd.earthlink.net ([207.217.120.74]:17613 "EHLO
        falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
        id <S129697AbQKXWpu>; Fri, 24 Nov 2000 17:45:50 -0500
Message-ID: <07bf01c05664$15462210$0a25a8c0@wizardess.wiz>
From: "J. Dow" <jdow@earthlink.net>
To: <FyreMoon@fyremoon.net>, <coredumping@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <F198IZv0R1Cm7yvgffu00003ac1@hotmail.com> <60916.195.11.55.51.975075740.squirrel@www.fyremoon.net>
Subject: Re: About IP address
Date: Fri, 24 Nov 2000 14:15:41 -0800
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "John Crowhurst" <FyreMoon@fyremoon.net>

> > For example, Class B address range is 128.1.0.0 ~ 191.254.0.0
> > 
> > Why 128.0.0.0 and 191.255.0.0 can't use ?
> > 
> > I can't understand it
> 
> This is because its the network and broadcast addresses of a Class A address
> range. Simple answer :)

That is not a responsive answer, John. And since you gave it I issue you the
challenge to declare why 128.0.0.1 through 191.255.255.254 are not legal
address ranges.

{^_-}


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
