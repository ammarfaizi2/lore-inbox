Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266666AbSKHADo>; Thu, 7 Nov 2002 19:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266669AbSKHADo>; Thu, 7 Nov 2002 19:03:44 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:38901 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S266666AbSKHADn>; Thu, 7 Nov 2002 19:03:43 -0500
Date: Thu, 7 Nov 2002 19:10:22 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Robert Love <rml@tech9.net>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.46-mm1 with contest
Message-ID: <20021107191022.A5154@redhat.com>
References: <200211080953.22903.conman@kolivas.net> <1036712891.764.2055.camel@phantasy> <3DCAFE38.16DED3BF@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DCAFE38.16DED3BF@digeo.com>; from akpm@digeo.com on Thu, Nov 07, 2002 at 03:58:48PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 03:58:48PM -0800, Andrew Morton wrote:
> > Nice.
> 
> Mysterious.

Nah, that's the allocator changes kicking in.

		-ben
-- 
"Do you seek knowledge in time travel?"
