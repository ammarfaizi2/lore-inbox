Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266491AbSKGLfe>; Thu, 7 Nov 2002 06:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266492AbSKGLfe>; Thu, 7 Nov 2002 06:35:34 -0500
Received: from holomorphy.com ([66.224.33.161]:12452 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266491AbSKGLfc>;
	Thu, 7 Nov 2002 06:35:32 -0500
Date: Thu, 7 Nov 2002 03:39:38 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Ketil Froyn <kernel@ketil.froyn.name>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Majordomo results
Message-ID: <20021107113938.GC23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	Ketil Froyn <kernel@ketil.froyn.name>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20021107101602Z266439-32597+17764@vger.kernel.org> <Pine.LNX.4.44.0211071125530.12653-100000@lexx.infeline.org> <20021107103545.B7579@flint.arm.linux.org.uk> <20021107104455.GR26330@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107104455.GR26330@mea-ext.zmailer.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 10:35:45AM +0000, Russell King wrote:
>> No it won't.  davem has put protection against such mail loops into
>> this version of majordomo.  Its a real shame that people are so stupid
>> that they try this.

On Thu, Nov 07, 2002 at 12:44:55PM +0200, Matti Aarnio wrote:
>   It just generates looped messages that are bounced to the list owner.
>   Subscriber's message had these headers:  (yes, we do log EVERYTHING
>   sent to Majordomo.. We don't log everything sent to the lists, though.
>   There are a number of archives for that.)

Could these DoS attempts get filtered somehow?


Thanks,
Bill
