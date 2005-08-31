Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbVHaRgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbVHaRgI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 13:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbVHaRgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 13:36:08 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:20536 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964899AbVHaRgG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 13:36:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SCPhDgr1qHF7o4QLVx3sktaqEqZWy5I08p0VP5UW7QpWJSy/00qOjicJ3oU0ekuvmkRojhbBBuz5FAXlIGMEetngQ7wQi2msA9P5GRw3gmFn4eYW05BulEzX+LQ9ZO3NLQRXjUpi8IArp5Ei5GPPYZSFXnQVfPJyFlfdQ0KoHMo=
Message-ID: <9a9e5ab90508311036386e88f4@mail.gmail.com>
Date: Wed, 31 Aug 2005 23:06:05 +0530
From: Nilesh Agrawal <nilesh.agrawal@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty problem
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1125507010.3355.67.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a9e5ab90508310806114ab96b@mail.gmail.com>
	 <4315CA02.4000802@gmail.com>
	 <9a9e5ab905083108503285865b@mail.gmail.com>
	 <1125507010.3355.67.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2005-08-31 at 21:20 +0530, Nilesh Agrawal wrote:
> > mdacon: MDA with 8K of memory detected.
> > Console: switching consoles 1-16 to mono MDA-2 80x25
> 
> You've compiled in the MDA driver, probably not what you want to load on
> that hardware

I removed the MDA driver and it worked perfectly.
Thanks a lot.

-- 
And ye shall know the truth (source) and the truth shall set you free.
