Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVBJTyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVBJTyH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 14:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVBJTyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 14:54:07 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:7012 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261342AbVBJTyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 14:54:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZKDD33DgpfprHZIGU7DADHS9i0oPWwY8SJ7PUcyzjxCpFt6PfooCXJ1xA6/vHg2dI69SYvZt3thhUhnOFWFCjPztbIsZGjiN1EI9CtGkv/vDbykkb6+xwc3VGrUlq/6x8kJUZO/+cM+PHTXvfc7kaM1njXS5NpI45xWnqi/7D2g=
Message-ID: <d120d50005021011541cfed1c5@mail.gmail.com>
Date: Thu, 10 Feb 2005 14:54:03 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: trelane@digitasaru.net, Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Peter Osterlund <petero2@telia.com>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Fix ALPS sync loss
In-Reply-To: <20050209173533.GA12011@digitasaru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200502081840.12520.dtor_core@ameritech.net>
	 <20050209173533.GA12011@digitasaru.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2005 11:35:34 -0600, Joseph Pingenot
<trelane@digitasaru.net> wrote:
> From Dmitry Torokhov on Tuesday, 08 February, 2005:
> >Hi,
> >Here is the promised patch. It turns out protocol validation code was
> >a bit (or rather a byte ;) ) off.
> >Please let me know if it fixes your touchpad and I believe it would be
> >nice to have it in 2.6.11.
> 
> This patch seems to be working for me too.  Thanks a million, Dmitry!
>  I owe you a beer some time.  :)
> 

You are welcome. I am glad we got your touchpad going.

-- 
Dmitry
