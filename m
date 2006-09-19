Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWISIcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWISIcA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 04:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWISIcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 04:32:00 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:36601 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932209AbWISIb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 04:31:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cRm8KRI8fhXeIWFVUXVRECBxO208TfTzhg0tEcU8RJxpLCiMOXLjbG2LNi5unuUY4z5CxkTQ4GV4ZXbrpUl6lMYfdrvup9dcaPwcNf9+SJTjVmBvwWaregciybKXq0h3olhqgOnG21x1pOkTaZHrbYnThLD1lBTj6maX5pHxh20=
Message-ID: <9a8748490609190131r6942a484jae3e1165809000d3@mail.gmail.com>
Date: Tue, 19 Sep 2006 10:31:58 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: Math-emu kills the kernel on Athlon64 X2
Cc: billm@melbpc.org.au, billm@suburbia.net,
       "Linus Torvalds" <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <p73venk2sjw.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	 <p73venk2sjw.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Sep 2006 10:01:55 +0200, Andi Kleen <ak@suse.de> wrote:
> "Jesper Juhl" <jesper.juhl@gmail.com> writes:
>
> > Hi,
> >
> > If I enable the math emulator in 2.6.18-rc7-git2 (only version I've
> > tried this with) and then boot the kernel with "no387" then I only get
> > as far as lilo's "...Booting the kernel." message and then the system
> > hangs.
> >
> > The kernel is a 32bit kernel build for K8 and my CPU is a Athlon64 X2 4400+
>
> Do you have a .config? I tried it and it booted until mounting root.
>
Yes, I do. I'll mail it tonight when I get home from work.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
