Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTLESh5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTLESh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:37:57 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:1183 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S264271AbTLEShz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:37:55 -0500
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Filip Van Raemdonck'" <filipvr@xs4all.be>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Linux GPL and binary module exception clause?
Date: Fri, 5 Dec 2003 10:37:51 -0800
Organization: Cisco Systems
Message-ID: <002101c3bb5e$e36394e0$ca41cb3f@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <20031205181222.GA24882@debian>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nope, they #include Linux header files - at least in their 
> Linux version. 

So what? By the same argument they are derived work of Linux too.

This is exactly the flaw of "once you include my code, you are derived
work of mine".

> Even if one version does #include Unix headers, that 
> does not mean copyright to the rest of the code automatically belongs 
> to the Unix copyright holder.

This is not a matter of copyright. This is a matter of "being derived or
not".

> And we're not even talking about source code; we're talking about
> _binary modules_. Which do include object code which comes from GPLed
> (inline) code; and are thus derived works.

I disagree. 

It all depends on how significant the inlined code is compared to the
whole work of the module. For inline functions, I don't see why using
them would be a significant part - by definition "inline" means
"small/trivial", otherwise you would not have inlined them.

Otherwise, since SCO found a few lines of code copied from Unix in Linux
source, are we saying the whole million lines of code is derived from
Unix?

> Regards,
> 
> Filip

