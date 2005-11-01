Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVKANDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVKANDz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 08:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVKANDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 08:03:55 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:18815 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750783AbVKANDy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 08:03:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WTIuD6KrAWAt2hC9743ln+U/6g1G/j63vXYgSBYqGlU9RN82TcsTAj74rxhkBCEJLJy8D8BTT5tEsnLBSM95tAXXBs49vaS+ixjyQuo3DDTIYUXnJm2FxJDLcOCYbZQ0yotPQdp1Qf/5MlfpQ4SRVcGUetrIHlPCHdPZ4Bpq+S0=
Message-ID: <84144f020511010503n740f296ev149ac33a443b9ca3@mail.gmail.com>
Date: Tue, 1 Nov 2005 15:03:53 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Ian Wienand <ianw@gelato.unsw.edu.au>
Subject: Re: [PATCH] Convert dmasound_awacs to dynamic input_dev allocation
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20051101103358.GA28394@cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051101020329.GA7773@cse.unsw.EDU.AU>
	 <200511010055.32726.dtor_core@ameritech.net>
	 <20051101060443.GF11202@cse.unsw.EDU.AU>
	 <200511010114.38632.dtor_core@ameritech.net>
	 <20051101103358.GA28394@cse.unsw.EDU.AU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, Ian Wienand <ianw@gelato.unsw.edu.au> wrote:
> Does anyone know what the eqivalent of 'cvs update -C file' is with
> git?  It is a common use-case for me to make a few changes, send off a
> diff and then get another one back which I want to apply to the
> orignal.

Sounds you're looking for git checkout -f ?

                        Pekka
