Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSEOQev>; Wed, 15 May 2002 12:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316435AbSEOQeu>; Wed, 15 May 2002 12:34:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:21241 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316433AbSEOQeu>; Wed, 15 May 2002 12:34:50 -0400
Subject: Re: Linux 2.4.19pre8-ac3 -- thread_info?
From: Robert Love <rml@tech9.net>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Jan Nieuwenhuizen <janneke@gnu.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020515140455.GA2186@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 May 2002 09:34:45 -0700
Message-Id: <1021480485.910.0.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-15 at 07:04, J.A. Magallon wrote:

> On 2002.05.15 Jan Nieuwenhuizen wrote:
> >
> >It seems that 2.4.19pre8-ac3 introduced the use of thread_info, but
> >it's not defined in sched.h?
>
> Sure it has been added ?
> It can be the O1-sched patch or the O1-updates from rml, when extracted from
> 2.5 still use that.

Yes, it was a typo on my behalf.  I posted a patch yesterday or get -ac4
which has the fix.  Thanks.

	Robert Love

