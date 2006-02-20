Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbWBTRB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbWBTRB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbWBTRB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:01:59 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:21947 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161036AbWBTRBz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:01:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KGFK8Y2+BF1d/uiyN1s3bHGYidOFej4bnpJ/9fE/3UxslyBECgNhVA3FCQ+nCxA3Hw6PtkH1VRJPAd2vc6u5JsMGcFrAzRHzZZKyhyQ1rEF3iMAd2gaMkR8r00MB0LKBqEW7Xie6aOxNDAc7d9681zaH3tUsGu2Bl/iSlKX493g=
Message-ID: <9e0cf0bf0602200901l7df58e9q92dcaee0bd9eba30@mail.gmail.com>
Date: Mon, 20 Feb 2006 19:01:53 +0200
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Cc: "=?ISO-8859-1?Q?Sebastian_K=FCgler?=" <sebas@kde.org>, nigel@suspend2.net,
       "Matthias Hensler" <matthias@wspse.de>, rjw@sisk.pl,
       "kernel list" <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net
In-Reply-To: <20060220130125.GA17627@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <20060218142610.GT3490@openzaurus.ucw.cz>
	 <20060220093911.GB19293@kobayashi-maru.wspse.de>
	 <200602201105.35378.sebas@kde.org> <20060220130125.GA17627@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/06, Pavel Machek <pavel@ucw.cz> wrote:
> I'd love to have Nigel helping me and kernel, but he's not
> interested. He wants suspend2 merged, he does not want better suspend
> in kernel.

You are waaaay out of line!!!!
We _ALL_ want a better suspend in kernel!
You are the one who reject all other ideas and offerings.
I think that almost every one who follow/read the thread understand
that... Maybe except of you...

> Nigel is not really maintaining it. He's willing to solve small
> problems, but not the big ones.

What?
It is a pleasure to work with Nigel!!! Unlike some other people here.
Just read the suspend2 mailing lists and understand... Or maybe you
are too blind to understand how to approach people.
When was the last time _YOU_ offered a new feature that helps the end-user?
In fact swsusp is the one that is not maintained... It is just a toy
for some programmers to say: "Hay I know to do that differently!"

> uswsusp and swsusp share most of the important code (go take a
> look). No, in-kernel swap writing is not going to be improved too
> much, just the bugs fixed. That means very stable swsusp in kernel...

But both will not be able to write image to a file, right?
Both will not be able to write the image to the network, right?
And what about the administrative interface (/proc), this is also not provided.

So swsusp and uswsusp will never reach the level of suspend2... Some
of us understand that... But of course you reject the need... And
going your way.... Although you know that providing the same level of
features will require more in-kernel modifications.

Pavel, people are trying to help you!
It is one thing to reject their help.
But why to insult them?

Alon Bar-Lev.
