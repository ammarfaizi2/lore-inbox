Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVK3BPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVK3BPw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 20:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVK3BPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 20:15:51 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:10056 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750757AbVK3BPv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 20:15:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XQUTklLUGPOlTPG8Urjgr+P0HqbDGo+rokcD4w2OM2y946uxcJFvgRtIfc2xKyi7qNicGkAY6CZFcfKIvTj4gsUZA/muD3TKLEujzjbBqxqyRZTmFkW1R8otPucy6q3f0rgwDdkqrYwc2QuaJMDyiKdF9y8RgNoSceKGkRGEdoc=
Message-ID: <35fb2e590511291715t4481c504hb2eb60e8b263ecb2@mail.gmail.com>
Date: Wed, 30 Nov 2005 01:15:50 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: floppy regression from "[PATCH] fix floppy.c to store correct ..."
Cc: Andrew Morton <akpm@osdl.org>, cp@absolutedigital.net,
       linux-kernel@vger.kernel.org, jcm@jonmasters.org, viro@ftp.linux.org.uk,
       hch@lst.de
In-Reply-To: <438CCF65.4060506@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net>
	 <20051116005958.25adcd4a.akpm@osdl.org>
	 <20051119034456.GA10526@apogee.jonmasters.org>
	 <20051121233131.793f0d04.akpm@osdl.org>
	 <35fb2e590511220356x75a951f1t8a36d0556a940751@mail.gmail.com>
	 <20051122141628.41f3134f.akpm@osdl.org> <438B4E85.2060801@tmr.com>
	 <35fb2e590511281233r49668895hc3295fce4cfe891b@mail.gmail.com>
	 <438CCF65.4060506@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/05, Bill Davidsen <davidsen@tmr.com> wrote:

> You missed my point... Andrew suggested that since the new behaviour is
> not fully functional that a revert was in order until a new version is
> available. I agreed, because the old broken behaviour is at least
> expected, while waiting for the floppy driver to check is not, and old
> problems are less likely to cause a problem until a fixed fix is in place.

Nope. I got your point perfectly and I agree with you. I'll resubmit a
longer term fix later.

Jon.
