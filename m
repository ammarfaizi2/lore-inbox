Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264173AbUDWS3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264173AbUDWS3z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 14:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbUDWS3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 14:29:55 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:22150 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264173AbUDWS3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 14:29:54 -0400
Date: Fri, 23 Apr 2004 11:34:35 -0700
From: Paul Jackson <pj@sgi.com>
To: Timothy Miller <miller@techsource.com>
Cc: tytso@mit.edu, miquels@cistron.nl, linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
Message-Id: <20040423113435.245f918a.pj@sgi.com>
In-Reply-To: <40895CFF.6010307@techsource.com>
References: <408951CE.3080908@techsource.com>
	<c6bjrd$pms$1@news.cistron.nl>
	<20040423174146.GB5977@thunk.org>
	<40895CFF.6010307@techsource.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> SO... in addition to the brilliance of AS, is there anything else that 
> can be done (using compression or something else) which could aid in 
> reducing seek time?

Buy more disks and only use a small portion of each for all but the
most infrequently accessed data.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
