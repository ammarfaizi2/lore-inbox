Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWCGPVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWCGPVR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 10:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWCGPVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 10:21:17 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:43199 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751203AbWCGPVR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 10:21:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IkNj5ezxXu3lFAvzeIISaUfO5SfQqNE5YQRaTAsxZ3uekhe4d+Dm6Qyal0cNbeEsuNZKhCK92wB36SIr+F5T8ZOsYLaXtBBuOf9iZ+Pj8x9zDfcOcvU+lZbDUO8QxH8/aA5vv/rxsA5Jt04B5UheF5bErNRmPGkQwreTsMDVNCw=
Message-ID: <625fc13d0603070721n1f6bd07bh5265ebc145a5bd82@mail.gmail.com>
Date: Tue, 7 Mar 2006 09:21:16 -0600
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Al Boldi" <a1426z@gawab.com>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200603071744.09749.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603071744.09749.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/06, Al Boldi <a1426z@gawab.com> wrote:
> > > > API design is not rocket science, it just requires effort.
> > >
> > > Agreed.
> > >
> > > However history does show that most people get API design wrong, at
> > > least the first time.
> > >
> > > So the question is can we get good enough at review that we can live
> > > with the few mistakes that make it through?
> >
> > Exactly.
> >
> > Combined with the fact that we do not have many reviewers (it's a
> > thankless, grumpy job), makes it very hard to make it "good enough"...
>
> There is a secret in creating a successful API; it's called ABSTRACTION.

This is about ABI not API.  There is no API in the kernel.  There _is_ and ABI.

josh
