Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbTDGJ1t (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 05:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTDGJ1t (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 05:27:49 -0400
Received: from pat.uio.no ([129.240.130.16]:39323 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263361AbTDGJ1s (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 05:27:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16017.18242.544290.263300@charged.uio.no>
Date: Mon, 7 Apr 2003 11:39:14 +0200
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@digeo.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       felipe_alfaro@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5: NFS troubles
In-Reply-To: <1049675270.753.166.camel@localhost>
References: <1049630768.592.24.camel@teapot.felipe-alfaro.com>
	<shsbrzjn5of.fsf@charged.uio.no>
	<20030406171855.6bd3552d.akpm@digeo.com>
	<1049675270.753.166.camel@localhost>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Robert Love <rml@tech9.net> writes:

     > I have not yet figured out whether its the 2.5 kernel on the
     > client or the newly-upgraded Red Hat 9 on the server... but I
     > suspect the 2.5 kernel on the client.

There is a problem with generic reads under 2.5. Now that I think I've
got the resource management under control, I've started to look into
it.

Cheers,
  Trond

