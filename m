Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbVLEPoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbVLEPoL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 10:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbVLEPoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 10:44:11 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:61979 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751376AbVLEPoK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 10:44:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MgDmKxt8yhpGBiKeW8SjiIaHCUyoKIoFUYRa+QRwUo5Pz743wxOuVRJ65wnJg5h9dwsQezsRkM1wshsrwLZw1Zh66xYBv5MvSBx81f8b8f8FP7s6ONIqVeXb0XS7IqfWHLjD7ct+ZivBPsOl2s63bJ8jTekSoKLib5bWZXuKRGE=
Message-ID: <84144f020512050744l3cc8289dh9a34c6f60311b6aa@mail.gmail.com>
Date: Mon, 5 Dec 2005 17:44:08 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Jakob Oestergaard <jakob@unthought.net>, Greg KH <greg@kroah.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
In-Reply-To: <20051205151753.GB4179@unthought.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051203135608.GJ31395@stusta.de>
	 <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>
	 <20051203201945.GA4182@kroah.com>
	 <20051204170049.GA4179@unthought.net>
	 <20051204223931.GA8914@kroah.com>
	 <20051205151753.GB4179@unthought.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Dec 04, 2005 at 02:39:31PM -0800, Greg KH wrote:
> > Have you filed a but at bugzilla.kernel.org about this?  If not, how do
> > you expect it to get fixed?

On 12/5/05, Jakob Oestergaard <jakob@unthought.net> wrote:
> I don't expect to get it fixed. It's futile. It can get fixed in one
> version and broken two days later, and it seems the attitude is that
> that is just fine.

I don't think anyone breaks things on purpose. Please feel free to
report the bug as many times as necessary to get it fixed. You
shouldn't be complaining if you're not doing your part.

                                          Pekka
