Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbULBUBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbULBUBf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 15:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbULBUBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 15:01:35 -0500
Received: from pop.gmx.net ([213.165.64.20]:63136 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261743AbULBUA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 15:00:56 -0500
X-Authenticated: #4399952
Date: Thu, 2 Dec 2004 21:03:18 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: "Jack O'Quin" <joq@io.com>
Cc: Andrew Burgess <aab@cichlid.com>, linux-kernel@vger.kernel.org,
       jackit-devel@lists.sourceforge.net
Subject: Re: [Jackit-devel] Re: Real-Time Preemption,
 -RT-2.6.10-rc2-mm3-V0.7.31-19
Message-ID: <20041202210318.47c77872@mango.fruits.de>
In-Reply-To: <87d5xsehby.fsf@sulphur.joq.us>
References: <200412021546.iB2FkK5a005502@cichlid.com>
	<20041202170315.067d7853@mango.fruits.de>
	<87y8ggekds.fsf@sulphur.joq.us>
	<20041202175756.0e50f101@mango.fruits.de>
	<20041202180910.0d77cbbb@mango.fruits.de>
	<87d5xsehby.fsf@sulphur.joq.us>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 Dec 2004 11:32:49 -0600
"Jack O'Quin" <joq@io.com> wrote:

> Florian Schmidt <mista.tapas@gmx.net> writes:
> 
> > Hmm, i must have missed something in jackd's source. i thought
> > control->process() directly calls the clients process callback..
> 
> It does.

Then either i have misunderstood how it works, or the mechanism is still
buggy.. Wrote mail to Ingo. Will report to jackit-devel when i get an
answer.

Flo
