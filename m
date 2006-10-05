Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWJEQu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWJEQu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWJEQu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:50:58 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:49898 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932176AbWJEQu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:50:57 -0400
Message-ID: <4525364D.1000409@garzik.org>
Date: Thu, 05 Oct 2006 12:43:57 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Johannes Berg <johannes@sipsolutions.net>, Theodore Tso <tytso@mit.edu>,
       "John W. Linville" <linville@tuxdriver.com>,
       Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
References: <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <20061003231648.GB26351@thunk.org> <1159948179.2817.26.camel@ux156> <20061005163513.GC6510@bougret.hpl.hp.com>
In-Reply-To: <20061005163513.GC6510@bougret.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> 	Once again, your facts are totally wrong about Wireless
> Extensions.
> 	Have you ever looked at the code in the kernel ? I guarantee
> you that adding whatever specific WE translation is quite easy. In
> this precise case, this would only increase confusion, so this should
> be considered bad API practice.


Wireless Extensions has reached end-of-life, and so we only need to 
support what's out there in wide distribution.

	Jeff


