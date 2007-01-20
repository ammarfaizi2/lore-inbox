Return-Path: <linux-kernel-owner+w=401wt.eu-S932887AbXATDkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932887AbXATDkR (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 22:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbXATDkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 22:40:17 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:6997 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932887AbXATDkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 22:40:15 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fh66WTgZ5qEl+QUuL0ndYzf4Dv6tg16PyAszGrQg9qkZhECFUeX+zfqI69lXfYeRp73nlNzshSY2qcyTYNaQdhbKCc0eGimcW8WRdqdLtHU+PtylyZpMCMe2DxV5d0xY4AhQnOWbBAcBLsFWjNtWZL3KWTx6jGd7rxMpAB6iQvY=
Message-ID: <8bd0f97a0701191940s32aff538r71afb96463b1a59b@mail.gmail.com>
Date: Fri, 19 Jan 2007 22:40:15 -0500
From: "Mike Frysinger" <vapier.adi@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [RPC][PATCH 2.6.20-rc5] limit total vfs page cache
Cc: "Aubrey Li" <aubreylee@gmail.com>,
       "Vaidyanathan Srinivasan" <svaidy@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Robin Getz" <rgetz@blackfin.uclinux.org>,
       "Hennerich, Michael" <Michael.Hennerich@analog.com>
In-Reply-To: <45B18344.5020507@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50701171923g48c8652ayd281a10d1cb5dd95@mail.gmail.com>
	 <45B0DB45.4070004@linux.vnet.ibm.com>
	 <6d6a94c50701190805saa0c7bbgbc59d2251bed8537@mail.gmail.com>
	 <45B112B6.9060806@linux.vnet.ibm.com>
	 <6d6a94c50701191804m79c70afdo1e664a072f928b9e@mail.gmail.com>
	 <45B17D6D.2030004@yahoo.com.au>
	 <8bd0f97a0701191835y49a61e7jb65a3b63f906ca56@mail.gmail.com>
	 <45B18344.5020507@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/07, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Maybe, if you are talking about my advice to fix userspace... but you
> *are* going to contribute those changes back for the nommu community
> to use, right? So the end result of that is _not_ actually tweaking the
> end solutions.

not quite sure what you're referring to here, but our approach is to
contribute everything back in an acceptable form
-mike
