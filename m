Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWEARyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWEARyH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWEARyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:54:07 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:48541 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932186AbWEARyF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:54:05 -0400
Subject: Re: 2.6.17-rc2-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Martin Bligh <mbligh@google.com>
Cc: Andrew Morton <akpm@osdl.org>, apw@shadowen.org, linuxppc64-dev@ozlabs.org,
       lkml <linux-kernel@vger.kernel.org>, ak@suse.de
In-Reply-To: <445644B7.7060807@google.com>
References: <4450F5AD.9030200@google.com>
	 <20060428012022.7b73c77b.akpm@osdl.org> <44561A1E.7000103@google.com>
	 <20060501100731.051f4eff.akpm@osdl.org>
	 <1146503960.317.1.camel@dyn9047017100.beaverton.ibm.com>
	 <445644B7.7060807@google.com>
Content-Type: text/plain
Date: Mon, 01 May 2006 10:55:05 -0700
Message-Id: <1146506105.317.4.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 10:26 -0700, Martin Bligh wrote:
> > I ran mtest01 multiple times with various options on my 4-way AMD64 box.
> > So far couldn't reproduce the problem (2.6.17-rc3-mm1).
> > 
> > Are there any special config or test options you are testing with ?
> 
> Config is here:
> 
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/amd64
> 
> It's just doing "runalltests", I think.

FWIW, I tried your config file on my 4-way AMD64 (melody) box 
and ran latest "mtest01" fine.

I am now trying runalltests. I guess, its time to bi-sect :(

Thanks,
Badari

