Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287908AbSABT3U>; Wed, 2 Jan 2002 14:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287913AbSABT3K>; Wed, 2 Jan 2002 14:29:10 -0500
Received: from pop.gmx.net ([213.165.64.20]:50923 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S287908AbSABT2z>;
	Wed, 2 Jan 2002 14:28:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Sebastian Roth <xsebbi@gmx.de>
Reply-To: xsebbi@gmx.de
Message-Id: <200201022028.04945@xsebbi.de>
To: adrian kok <adriankok2000@yahoo.com.hk>, linux-kernel@vger.kernel.org
Subject: Re: system.map
Date: Wed, 2 Jan 2002 20:30:00 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com>
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi all

hello,

> Why sometimes I don't need to copy the system.map to
> /boot when I update the kernel
> and the system also can boot?

> Is it correct?

yes, this is correct. I think this System.map contains only some useful 
information about modules for the kernel. At my system works that too. But I 
think it's better when you copy this file to /boot. :-)

> Thank you


Bye,
Sebastian
