Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWATWA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWATWA4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 17:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWATWA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 17:00:56 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:45759 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932215AbWATWAz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 17:00:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QPsOrFCpTlg4MDEinT16//Zpm2XfC8vTDwjG0nXcCJtIG4YkhVpjbimFwVY1BJI64B0s4EWTJ4l/0n8cV4tLj1FD12XKJxBypJhpswh0KiyxRyHj/afq7slYC0pq54STpi4VLR3NJQKXP2lZeOFJgVV1GpI8YUcc601JSOnwKuc=
Message-ID: <d120d5000601201400p24a44923o5ae94b82492ee617@mail.gmail.com>
Date: Fri, 20 Jan 2006 17:00:54 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Michael Loftis <mloftis@wgops.com>
Subject: Re: Development tree, PLEASE?
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <0FA349BF620394796EB40A3A@d216-220-25-20.dynip.modwest.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
	 <43D10FF8.8090805@superbug.co.uk>
	 <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
	 <d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com>
	 <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com>
	 <9a8748490601201220h2d85fa4au780715ff287cf1eb@mail.gmail.com>
	 <0FA349BF620394796EB40A3A@d216-220-25-20.dynip.modwest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/06, Michael Loftis <mloftis@wgops.com> wrote:
>
>
> --On January 20, 2006 9:20:19 PM +0100 Jesper Juhl <jesper.juhl@gmail.com>
> wrote:
>
> > On 1/20/06, Michael Loftis <mloftis@wgops.com> wrote:
> >>
> > [snip]
> >> I'm trying to think of a way to relate this better but I just can't.
> >> What's needed is a 'target' for incremental updates, things like minor
> >> changes, bugfixes, etc.  I feel like supporting entirely new hardware
> >
> > That's called a vendor kernel.
> > You pay the vendor money, the vendor maintains a stable (as in feature
> > frozen) kernel, backports bugfixes for you etc.
> > Take a look at the RedHat and SuSE enterprise kernels, they seem to be
> > what you want.
>
...
> RH is trying to be everything, which is fine for them and their intended audience.  I've never
> really been happy with their kernels, nor with their base os.  Many are
> though.
>
> Why can't a community do this though?  I guess the answer is there's no
> reason a community cant, jsut the mainline developers are not going to,
> because it's too much work.
>
...
>
> I think stable should also include bugfixes and updates without having to
> take (potentially, if not certainly) incompatible changes along with that.

Are you volunteering?

--
Dmitry
