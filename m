Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbTJaEu0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 23:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTJaEu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 23:50:26 -0500
Received: from fluent2.pyramid.net ([206.100.220.213]:50051 "EHLO
	fluent2.pyramid.net") by vger.kernel.org with ESMTP id S262993AbTJaEuY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 23:50:24 -0500
X-Not-Legal-Opinion: IANAL I am not a lawyer
X-For-Entertainment-Purposes-Only: True
X-message-flag: Please update my contact to send plain-text mail only.
Message-Id: <5.2.1.1.0.20031030203917.01754ea0@fluent2.pyramid.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Thu, 30 Oct 2003 20:50:21 -0800
To: Scott Robert Ladd <coyote@coyotegulch.com>,
       "Theodore Ts'o" <tytso@mit.edu>
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Re: Things that Longhorn seems to be doing right
Cc: Erik Andersen <andersen@codepoet.org>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3FA08C42.6050107@coyotegulch.com>
References: <20031030015212.GD8689@thunk.org>
 <3F9F7F66.9060008@namesys.com>
 <20031029224230.GA32463@codepoet.org>
 <20031030015212.GD8689@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:57 PM 10/29/2003 -0500, Scott Robert Ladd wrote:
>MySQL wouldn't need to be shoved into the kernel; a small, fast database 
>engine (one of my professional specialities, BTW) could provide metadata 
>services in a file system module. SQL is a bloated pig; an effective file 
>system needs to be both useful and efficient, leading me to think that we 
>should consider a more succinct query mechanism for any metadata-based 
>file system.

I might add that Microsoft didn't invent the 
database-in-the-operating-system concept -- IBM has had that concept for 
years with the AS-400 line.  Indeed, the announcement by Microsoft sounds 
like MS is really courting the business marketplace; perhaps it is willing 
to give up some markets to go after what it may view as its core 
customers.  How many science/engineer types willingly use Windows as other 
than a window (pardon the pun) to a Unix-type system and as an 
office-productivity tool?

One way Microsoft could "beat Linux" is to bolster its integration with 
business mainframes, providing data layering tools designed for business 
applications "out of the box" -- a task that Linux itself (the operating 
system) could never, and should never, do.  If some company or group wants 
to put in the skull sweat and build a distribution that would do the deed, 
with kernel mods and userland support, more power to them.


-- 
"People who seem to have had a new idea have often just stopped having an 
old idea." -- Dr. Edwin H. Land  

