Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbTEEJGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 05:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTEEJGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 05:06:41 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:40713 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262113AbTEEJGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 05:06:41 -0400
Date: Mon, 5 May 2003 10:19:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Cc: Terje Eggestad <terje.eggestad@scali.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030505101907.A15155@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>,
	Terje Eggestad <terje.eggestad@scali.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1052122784.2821.4.camel@pc-16.office.scali.no> <Pine.SGI.4.10.10305051545480.8168393-100000@Sky.inp.nsk.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SGI.4.10.10305051545480.8168393-100000@Sky.inp.nsk.su>; from D.A.Fedorov@inp.nsk.su on Mon, May 05, 2003 at 04:01:25PM +0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 04:01:25PM +0700, Dmitry A. Fedorov wrote:
> Almost all of my third-party drivers are broken by this.
> What is worse, redhat "backported" this "feature" to their 2.4
> patched kernels and now I should distinguish 2.4 and "redhat 2.4"
> in my compatibility headers.

What about just fixing your drivers instead of moaning?  If you submit
a pointer to your driver source and explain what you want to do someone
might even help you..

