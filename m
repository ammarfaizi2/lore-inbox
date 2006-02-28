Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbWB1Waz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbWB1Waz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 17:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWB1Way
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 17:30:54 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:40737 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932576AbWB1Way convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 17:30:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=urajpkyjWdwtJI+rVb+d8BwQA0OpFaBzXMENIGXUAhOfkUCpbznD0Hob8z+pe8nIRAImaK+NW2n1iAm3mnqSpEaZEZFR3Bl1JM1hK2QyadEiLvaxyO151EYYa1zUwxrOQULrGrsdtjegrhfmTPW2NKU3udJqLmV7ZQsOITTmYQY=
Message-ID: <9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
Date: Tue, 28 Feb 2006 23:30:45 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jiri Slaby" <slaby@liberouter.org>
Subject: Re: 2.6.16-rc5-mm1
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4404CE39.6000109@liberouter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060228042439.43e6ef41.akpm@osdl.org>
	 <9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	 <4404CE39.6000109@liberouter.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/06, Jiri Slaby <slaby@liberouter.org> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Jesper Juhl napsal(a):
> > Since I'm in X when the lockup happens and I don't have enough time
> > from clicking the eclipse icon to the box locks up to make a switch to
> > a text console I don't know if an Oops or similar is dumped to the
> > console (there's nothing in the locks after a reboot)  :-(
> So why don't just run eclipse from console (DISPLAY=... eclipse), or use atd,
> crond... (less common variants)?
>

Good idea, thanks. Dunno why I didn't think of that.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
