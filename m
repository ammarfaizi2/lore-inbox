Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVHRGNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVHRGNA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 02:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVHRGM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 02:12:59 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:40392 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750817AbVHRGM7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 02:12:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ka83GxgqujvURzD8CT+WdbHXBBz2G2UD+Fsfrv0/qRDqmatVk0t200fCz5D9Mkrq0vXwHb7wVBWg/Z3cEFqZEbyYmdGHKNA9LAuZ3Wf2Bo9gqlE9sdybsWTWHqRdVL6KBJm4EREQPbQXD4CllloK0QegUm2FetZuYXEZ5SjaJYE=
Message-ID: <3aa654a4050817231235710bc@mail.gmail.com>
Date: Wed, 17 Aug 2005 23:12:57 -0700
From: Avuton Olrich <avuton@gmail.com>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: ACPI Standby and nvidia ethernet driver causes network errors and drops
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43041DDC.8050000@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43041DDC.8050000@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/05, Manfred Spraul <manfred@colorfullife.com> wrote:

> Could you try the attached patch? Lots of error are often caused by half
> duplex/full duplex mismatches, and such a bug was just fixed.

Absolutely, it's compiled, I'm testing it right now, if you don't hear
from me in 24 hours it worked :)

Thanks for the quick response,
avuton
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
