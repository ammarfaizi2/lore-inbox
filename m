Return-Path: <linux-kernel-owner+w=401wt.eu-S1751192AbWLMVr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWLMVr2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 16:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWLMVr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 16:47:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46211 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbWLMVr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 16:47:26 -0500
Date: Wed, 13 Dec 2006 13:47:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
Cc: Greg KH <gregkh@suse.de>, "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Message-Id: <20061213134721.d8ff8c11.akpm@osdl.org>
In-Reply-To: <45807182.1060408@mbligh.org>
References: <20061213195226.GA6736@kroah.com>
	<Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
	<f2b55d220612131238h6829f51ao96c17abbd1d0b71d@mail.gmail.com>
	<20061213210219.GA9410@suse.de>
	<45807182.1060408@mbligh.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 13:32:50 -0800
Martin Bligh <mbligh@mbligh.org> wrote:

> So let's come out and ban binary modules, rather than pussyfooting
> around, if that's what we actually want to do.

Give people 12 months warning (time to work out what they're going to do,
talk with the legal dept, etc) then make the kernel load only GPL-tagged
modules.

I think I'd favour that.  It would aid those people who are trying to
obtain device specs, and who are persuading organisations to GPL their drivers.

(Whereas the patch which is proposed in this thread hinders those people)
