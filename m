Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132551AbRDWXKL>; Mon, 23 Apr 2001 19:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132561AbRDWXJI>; Mon, 23 Apr 2001 19:09:08 -0400
Received: from t2.redhat.com ([199.183.24.243]:22010 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132562AbRDWXIU>; Mon, 23 Apr 2001 19:08:20 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3AE4B3D5.E026E291@mandrakesoft.com> 
In-Reply-To: <3AE4B3D5.E026E291@mandrakesoft.com>  <3829d3430e.3430e3829d@mysun.com> 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: pawel.worach@mysun.com, Chmouel Boudjnah <chmouel@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: i810_audio broken? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Apr 2001 00:08:10 +0100
Message-ID: <5393.988067290@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jgarzik@mandrakesoft.com said:
>  esd needs a special argument, -r RATE [iirc], in order to tell esd
> that it is dealing with a locked rate codec.

Isn't there an ioctl for that?

--
dwmw2


