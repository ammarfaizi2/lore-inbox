Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbTDLKOI (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 06:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbTDLKOI (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 06:14:08 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:26278 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263227AbTDLKOI (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 06:14:08 -0400
Date: Sat, 12 Apr 2003 22:29:57 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Completely new idea to virtual memory
In-reply-to: <200304120554_MC3-1-341A-4160@compuserve.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: John Bradford <john@grabjohn.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1050143397.5715.11.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <200304120554_MC3-1-341A-4160@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-04-12 at 21:52, Chuck Ebbert wrote: 
>   o if swsusp does not need to write already-backed pages it could
>     reduce suspend time

Hmmm. Not sure if it's worth the time taken to code & run figuring out
if it's already backed, though :>. Would we ever be talking about a
significant proportion of pages?

Regards,

Nigel

