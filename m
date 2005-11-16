Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbVKPBMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbVKPBMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 20:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbVKPBMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 20:12:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:181 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965082AbVKPBMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 20:12:20 -0500
Date: Tue, 15 Nov 2005 17:12:11 -0800
From: Paul Jackson <pj@sgi.com>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: raybry@mpdtxmail.amd.com, serue@us.ibm.com, linux-kernel@vger.kernel.org,
       frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-Id: <20051115171211.2f6404b6.pj@sgi.com>
In-Reply-To: <437A6772.6020700@fr.ibm.com>
References: <20051114212341.724084000@sergelap>
	<200511151321.08860.raybry@mpdtxmail.amd.com>
	<20051115194127.GB17287@sergelap.austin.ibm.com>
	<200511151430.35504.raybry@mpdtxmail.amd.com>
	<437A6772.6020700@fr.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric wrote:
> Well, we've already migrated some pretty ugly applications, database
> engines, without modifying them :)

You will have to teach us how it is done.

As you likely know by now, Linux doesn't incorporate new technology
en mass.  We sniff and poke at it, break it down into its constituent
elements and reconstitute it in ways that seem to fit Linux better.
It's all part of how we keep the body Linux healthy.

Especially for things like this that touch many of the more interesting
kernel constructs, the end result seldom resembles the initial input.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
