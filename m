Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVHHRYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVHHRYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVHHRYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:24:34 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:653 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932122AbVHHRYd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:24:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T8YMM74R+FlfFfCYu5Si6K2nta/inpkIFVpan9h+WWyX0G6zWhmTe/b9RYLFi2uKndUpPvTe8ZWgIeodBUT8hoHWmAOiKpqL0IJ3XHk1SbswofIEAP7HdtZnRMvbapMpNB37SbPCThEn541ghb3YcAN7TCiYGKMY6prqozxFFoA=
Message-ID: <1e62d13705080810247d9c9549@mail.gmail.com>
Date: Mon, 8 Aug 2005 22:24:32 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Highmemory Problem with RHEL3 .... 2.4.21-5.ELsmp
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1123489056.3245.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1e62d137050807205047daf9e0@mail.gmail.com>
	 <1123489056.3245.28.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Arjan,

On 8/8/05, Arjan van de Ven <arjan@infradead.org> wrote:
> 
> 1) you probably should use RH support for this
> 2) you forgot to attach your sourcecode / URL to that, including the
>    full source of your module.
> 

I already mentioned my code and some details in my previous mail on
the list !!!! Can u check and help me out or I hav to send that again
???? And as far as Redhat Support concerns that problem is not related
to Redhat because I reserved memory by placing the code in the
arch/i386/mm/init.c file in one_highpage_init function not through
mem= option of the kernel ......

Waiting for your response and help .....


-- 
Fawad Lateef
