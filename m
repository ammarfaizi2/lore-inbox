Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWE3EJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWE3EJV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 00:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWE3EJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 00:09:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:46031 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751463AbWE3EJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 00:09:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=NdPMciRKgwPhwEX3qgrnA7t0HihQZTtuCHbLMkOVvMu3FjwX9EWW1e8CZpjg7eFhqPgoMVYOA202gARiB3dSyuaqqoYC09o8jNs4tuFCZPp/yXsWR5qH98qjPnVzk97w5EFpvWl9IavHiF1dPGSidemJCJrQ1/pUiLbk2R6c8hU=
Message-ID: <35fb2e590605292109w42dc3ee8ud4545b9a23ff5933@mail.gmail.com>
Date: Tue, 30 May 2006 05:09:19 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [ANNOUNCE] Linux Device Driver Kit available
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060529214306.GA10875@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060524232900.GA18408@kroah.com>
	 <35fb2e590605280229g76e75419h10717238e15e7347@mail.gmail.com>
	 <20060529214306.GA10875@kroah.com>
X-Google-Sender-Auth: 81e147fc3f3235e2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/06, Greg KH <greg@kroah.com> wrote:
> On Sun, May 28, 2006 at 10:29:12AM +0100, Jon Masters wrote:
> > On 5/25/06, Greg KH <greg@kroah.com> wrote:
> > Random ideas:

> > * Bootable Damn Small Linux (DSL) or similar.

> No, I don't want to get into the distro business.  Already do enough of
> that work at my day job :)

Fair enough. I recommended that because of it making life easier for
running LXR and the fact that DSL has a boot method for running under
Qemu *on Windows*, so you can appeal to the people who want to just
shove a disc in their Windows box and get a lot of access to dynamic
content like LXR.

Jon.
