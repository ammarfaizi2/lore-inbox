Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUFJSCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUFJSCz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 14:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUFJSCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 14:02:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36501 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262175AbUFJSCy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 14:02:54 -0400
Message-ID: <40C8A241.50608@pobox.com>
Date: Thu, 10 Jun 2004 14:02:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Tomlinson <edt@aei.ca>, Andrew Morton <akpm@osdl.org>
Subject: Re: flush cache range proposal (was Re: ide errors in 7-rc1-mm1 and
 later)
References: <1085689455.7831.8.camel@localhost> <20040605092447.GB13641@suse.de> <20040606161827.GC28576@bounceswoosh.org> <200406100238.11857.bzolnier@elka.pw.edu.pl> <20040610061141.GD13836@suse.de> <20040610164135.GA2230@bounceswoosh.org> <40C89F4D.4070500@pobox.com>
In-Reply-To: <40C89F4D.4070500@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, also:

We'll need to write up precisely _why_ this is used, and give some 
examples of usage, for people reading the proposal (mostly T13-ish 
people) who have not been following the lkml barrier discussion closely.

	Jeff



