Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTFDXYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 19:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTFDXYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 19:24:10 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:14534 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S264292AbTFDXYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 19:24:09 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Tom Rini <trini@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc7
References: <Pine.LNX.4.55L.0306031353580.3892@freak.distro.conectiva>
	<877k83xbbw.fsf@sycorax.lbl.gov> <20030603192711.GA22150@gtf.org>
	<873cirx79r.fsf@sycorax.lbl.gov>
	<20030603201434.GA803@ip68-0-152-218.tc.ph.cox.net>
	<1054697728.5514.0.camel@rth.ninka.net>
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: Wed, 04 Jun 2003 16:37:24 -0700
In-Reply-To: <1054697728.5514.0.camel@rth.ninka.net> (davem@redhat.com)
Message-ID: <87smqp8le3.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> On Tue, 2003-06-03 at 13:14, Tom Rini wrote:
>> > gcc (GCC) 3.3 (Debian)
>> > GNU ld version 2.14.90.0.4 20030523 Debian GNU/Linux
>> 
>> That would do it.
>
> I don't trust anything past gcc-3.2.x on sparc and sparc64.
> Use 3.3.x and later at your own peril.

recompiled with gcc-3.2.3 and the kernel not only compiled but also
booted. thank you.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
