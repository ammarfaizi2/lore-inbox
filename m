Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVLZSgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVLZSgY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 13:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbVLZSgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 13:36:24 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48772 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932075AbVLZSgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 13:36:23 -0500
Subject: Re: recommended mail clients [was] [PATCH] ati-agp suspend/resume
	support (try 2)
From: Lee Revell <rlrevell@joe-job.com>
To: jason@stdbev.com
Cc: rostedt@goodmis.org, jaco@kroon.co.za, linux-kernel@vger.kernel.org,
       pavel@ucw.cz, s0348365@sms.ed.ac.uk
In-Reply-To: <0f197de4ee389204cc946086d1a04b54@stdbev.com>
References: <43AF7724.8090302@kroon.co.za> <43AFB005.50608@kroon.co.za>
	 <1135607906.5774.23.camel@localhost.localdomain>
	 <200512261535.09307.s0348365@sms.ed.ac.uk>
	 <1135619641.8293.50.camel@mindpipe>
	 <0f197de4ee389204cc946086d1a04b54@stdbev.com>
Content-Type: text/plain
Date: Mon, 26 Dec 2005 13:24:22 -0500
Message-Id: <1135621463.8293.68.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-26 at 12:09 -0600, Jason Munro wrote:
> Would the ability to pull the patch from
> the message body (assuming there was an agreed upon patch termination
> string) as a separate file/download be useful? 

No because patch(1) does that for you, it's one of the key features -
you can just save the message with a (non-mangled!) patch anywhere in
the text and the patch utility will do the right thing.  This is why
EOF, a .sig or whatever, before or after the patch is OK, *as long as
the mailer did not alter the patch itself*.

Lee

