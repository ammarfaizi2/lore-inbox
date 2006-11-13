Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932679AbWKMS1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbWKMS1u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755319AbWKMS1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:27:50 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:48967 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1755318AbWKMS1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:27:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xg+CrkJxQxS8DwiYlpd3A941zJ9VOvK0m4FZ1eaLa3XpFJi1VTRlEHyQNI2wKG4bBaSIC3mTx9ERVgAHX+8bGBjBncWPkzaYYo/3xGf74HA3xPaYMyRTkMUN2h+Jce/LBDMH2aHrzpyuzllZz78Iw/tcLiTXvN7dnt5zApzulMo=
Message-ID: <cda58cb80611131027h5052bf80va06003c23b844fe@mail.gmail.com>
Date: Mon, 13 Nov 2006 19:27:46 +0100
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "James Simmons" <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] fbmem: is bootup logo broken for monochrome LCD ?
Cc: "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45535C08.5020607@innova-card.com>
	 <Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org>
	 <cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com>
	 <Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/06, James Simmons <jsimmons@infradead.org> wrote:
>
> >> There are quite a few bugs in the code. I have a patch I have been working
> >> on for some time. The patch does the following:
> >>
> >
> > I'd like to give your patch a try but have some trouble to apply it
> > cleanly. Care to resend it ?
>
> Which tree are you working off ?> The patch is against linus git tree.
>

It seems that you use "format=flowed" with your mailer. Can you try to
disable it ?

Even if I save the message to a file, the patch is still corrupted...

Thanks
-- 
               Franck
