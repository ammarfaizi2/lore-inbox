Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVAUUGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVAUUGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 15:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVAUUGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 15:06:41 -0500
Received: from pD9F87519.dip0.t-ipconnect.de ([217.248.117.25]:64641 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S262478AbVAUUGa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 15:06:30 -0500
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: 2.6.10 dies when X uses PCI radeon 9200 SE, binary search result
Date: Fri, 21 Jan 2005 21:05:12 +0100
Organization: privat
Message-ID: <csrn9o$b83$1@pD9F87519.dip0.t-ipconnect.de>
References: <fa.jfkohta.1il0fq0@ifi.uio.no> <fa.hh8592m.qji2ie@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@fu.berlin.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.4) Gecko/20050112
X-Accept-Language: de, en-us, en
In-Reply-To: <fa.hh8592m.qji2ie@ifi.uio.no>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Helge,

Helge Hafting schrieb:
> On Sun, Jan 16, 2005 at 10:41:23PM +1100, Dave Airlie wrote:
>> > 
>> > I'm fine with adding this code, but we still don't know if this is the
>> > cause of his problem. The debug output can determine if this really is
>> > the source of the problem or if it is somewhere else.
>> > 
>> 
>> I actually doubt it is this stuff.. my guess is that it is something
>> nasty like ACPI breaking int10 for X or something like that... it
>> seems a lot more subtle than the usually things that break when we
>> mess with the DRM :-)

Which glibc do you use? I have problems with glibc 2.3.4, kernel 2.4.x and
X / Xorg while executing the int10-code of X. glibc 2.3.3 works fine for
me. But I could find another posting, which describes, that there are even
problems with glibc 2.3.3 and kernel 2.4.x.

It's new for me, that there could be problems with kernelversions of 2.6, too.

Therefore, it would be really interessting to know, which glibc version
you are using.


Kind regards,
Andreas Hartmann
