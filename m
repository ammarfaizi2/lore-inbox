Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbTD2JCd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 05:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTD2JCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 05:02:33 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:932 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261287AbTD2JCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 05:02:32 -0400
Date: Tue, 29 Apr 2003 02:14:44 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, <mc@cs.stanford.edu>
Subject: Re: [CHECKER] 3 potential user-pointer errors in drivers/usb/serial
 that can print out arbitrary kernel data
In-Reply-To: <20030429072500.GA4616@kroah.com>
Message-ID: <Pine.GSO.4.44.0304290211500.28403-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Thanks a lot for finding these, I think these problems are also in
> 2.4...

Thanks a lot for the confirmations and fixes. We are going to run our
checkers on 2.4.X soon.

-Junfeng

