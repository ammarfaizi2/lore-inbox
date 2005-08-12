Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVHLRgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVHLRgz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVHLRgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:36:54 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:31722 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750751AbVHLRgy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:36:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W91Smt5naL6NfJl3udWKRVkhNtbnw2JA2eodu0I0JAlB7NhXfrZQ7woaEqC/i8GUOC8j9SKBZi21bqJo77Tth1wA7/koG0NI048esq6l23ucz4iTYx13/ThLRd5A6+fmlsj43HcivnMZfxd0uhxA3DNh3Tzd1e6ae+/j3I2de0g=
Message-ID: <86802c4405081210361b6a71a2@mail.gmail.com>
Date: Fri, 12 Aug 2005 10:36:51 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] Re: 2.6.13-rc2 with dual way dual core ck804 MB
Cc: Mike Waychison <mikew@google.com>, Peter Buckingham <peter@pantasys.com>,
       linux-kernel@vger.kernel.org, "discuss@x86-64.org" <discuss@x86-64.org>
In-Reply-To: <20050812164100.GB22901@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <86802c4405081016421db9baa5@mail.gmail.com>
	 <86802c4405081017174c22dcd5@mail.gmail.com>
	 <86802c440508101723d4aadef@mail.gmail.com>
	 <20050811002841.GE8974@wotan.suse.de>
	 <86802c440508101743783588df@mail.gmail.com>
	 <20050811005100.GF8974@wotan.suse.de>
	 <86802c4405081123597239dff7@mail.gmail.com>
	 <20050812130725.GL8974@wotan.suse.de>
	 <86802c4405081209187e51878@mail.gmail.com>
	 <20050812164100.GB22901@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh.

On 8/12/05, Andi Kleen <ak@suse.de> wrote:
> On Fri, Aug 12, 2005 at 09:18:07AM -0700, yhlu wrote:
> > good, I will produce one patch next week.
> 
> I already did it in my tree.
> 
> -Andi
>
