Return-Path: <linux-kernel-owner+w=401wt.eu-S1754466AbWLRTl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbWLRTl1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 14:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754467AbWLRTl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 14:41:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41837 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754466AbWLRTl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 14:41:26 -0500
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ricardo Galli <gallir@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
References: <200612161927.13860.gallir@gmail.com>
	<Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
	<orwt4qaara.fsf@redhat.com>
	<86C272DA-23BA-4901-994D-6CABCC87A2DE@mac.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Mon, 18 Dec 2006 17:41:17 -0200
In-Reply-To: <86C272DA-23BA-4901-994D-6CABCC87A2DE@mac.com> (Kyle Moffett's message of "Sun\, 17 Dec 2006 11\:25\:01 -0500")
Message-ID: <orlkl56lgi.fsf@redhat.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 17, 2006, Kyle Moffett <mrmacman_g4@mac.com> wrote:

> On the other hand, certain projects like OpenAFS, while not license- 
> compatible, are certainly not derivative works.

Certainly a big chunk of OpenAFS might not be, just like a big chunk
of other non-GPL drivers for Linux.

But what about the glue code?  Can that be defended as not a derived
work, such that it doesn't have to be GPL?

If not, can the whole containing both the non-derivative work and the
source code providing the glue without which the whole wouldn't
fulfill its intended purpose be regarded as a mere aggregate, and thus
not be subject to the requirement that the whole be released under the
GPL?

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
FSF Latin America Board Member         http://www.fsfla.org/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
