Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbVIEUoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbVIEUoL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 16:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVIEUoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 16:44:11 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:57227 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750971AbVIEUoJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 16:44:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f1rip2CQ9+NVrZHyfAtq9LM9nDGPgUZNcmC5+nMPdBpS0xy2rw4SokUeAYwpLNOLR8JpYbOkTDEpMlX9/iksbaCYydJFQJIal4YZljHBO1Fc9d4vV9kR8HQkhl/WnT8LeNfLPOtSVRr9uTt/CY62Daf4Ogt6dSs00/ImaciBV94=
Message-ID: <dda83e78050905134420f06fbf@mail.gmail.com>
Date: Mon, 5 Sep 2005 13:44:08 -0700
From: Bret Towe <magnade@gmail.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: nfs4 client bug
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050905031825.GA22209@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <dda83e78050903171516948181@mail.gmail.com>
	 <dda83e7805090320053b03615d@mail.gmail.com>
	 <20050904103523.GA5613@electric-eye.fr.zoreil.com>
	 <dda83e78050904124454fc675a@mail.gmail.com>
	 <dda83e78050904135113b95c4a@mail.gmail.com>
	 <20050904215219.GA9812@fieldses.org>
	 <dda83e780509042008294fbe26@mail.gmail.com>
	 <20050905031825.GA22209@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, J. Bruce Fields <bfields@fieldses.org> wrote:
> On Sun, Sep 04, 2005 at 08:08:22PM -0700, Bret Towe wrote:
> > On 9/4/05, J. Bruce Fields <bfields@fieldses.org> wrote:
> > > Do you get anything from alt-sysrq-T?
> >
> > no i havent used that im usally in x when its freezing
> > x wont even switch to console would it still give me anything then?
> 
> Well, you can try something like:
>         alt-sysrq-T
> wait a couple seconds, then
>         alt-sysrq-S
>         alt-sysrq-U
>         alt-sysrq-B
> with maybe a second between each to give stuff a chance to get to disk.
> 
> Then if you're lucky you may find the stack dumps in your log after you
> reboot.

tried it and so far no luck ill keep trying a few more times and see
if i can get it
to spit somethin out to disk but i dont think ill be that lucky as that would
prob make life to easy wouldnt it?
