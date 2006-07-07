Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWGGGTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWGGGTJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 02:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWGGGTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 02:19:09 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60586 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751013AbWGGGTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 02:19:08 -0400
Date: Thu, 6 Jul 2006 23:18:51 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nagar@watson.ibm.com, jlan@sgi.com, Valdis.Kletnieks@vt.edu,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org,
       hadi@cyberus.ca, netdev@vger.kernel.org
Subject: Re: [PATCH] per-task delay accounting taskstats interface: control
 exit data through cpumasks]
Message-Id: <20060706231851.2f043927.pj@sgi.com>
In-Reply-To: <20060706025633.cd4b1c1d.akpm@osdl.org>
References: <44ACD7C3.5040008@watson.ibm.com>
	<20060706025633.cd4b1c1d.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Your email client performs space-stuffing.

Shailabh,

Some of us find that it is easier and more reliable to use a special
purpose script to send patches, rather than trying to do so via our
email client.  Even though my email client, Sylpheed, probably sends
patches just fine, I enjoy the convenience of preparing the patches
and mailing instructions in my editor, before sending them off with
such a utility.

One possible such utility is 'sendpatchset', which I maintain:

  http://www.speakeasy.org/~pj99/sgi/sendpatchset

It's a script, with the documentation embedded as the help message.

Especially when sending off multiple patches as a set, it provides
more reliable results than trying to prepare and send multiple such
simultaneous messages from the typical email client.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
