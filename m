Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282499AbRLKSpV>; Tue, 11 Dec 2001 13:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282502AbRLKSpC>; Tue, 11 Dec 2001 13:45:02 -0500
Received: from mercury.Sun.COM ([192.9.25.1]:13504 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S282499AbRLKSo6>;
	Tue, 11 Dec 2001 13:44:58 -0500
Message-ID: <3C164D93.A52BC1C2@sun.com>
Date: Tue, 11 Dec 2001 10:16:51 -0800
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12C5_V i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jason Baietto <jason.baietto@ccur.com>
CC: Tim Hockin <thockin@hockin.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Multiprocessor Control Interfaces
In-Reply-To: <200112110138.fBB1cqS09363@www.hockin.org> <1008088311.16656.4.camel@soybean>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Baietto wrote:
> 
> On Mon, 2001-12-10 at 20:38, Tim Hockin wrote:
> >
> > http://www.hockin.org/~thockin/pset.   Not finished, but could be.
> 
> Yes, many similarities.  I like the idea of having a single system
> call that provides so much multiprocessor control and information.
> If such a system call was ever standardized upon, I would gladly
> support it in my "run" tool, though I fear that it would always be
> functionally limited without /proc present.

Adding /proc/ interfaces like cpus_allowed or similar is just gravy on top
of pset, which I think is a good interface.

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
