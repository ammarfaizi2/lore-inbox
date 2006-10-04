Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWJDEnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWJDEnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 00:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWJDEnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 00:43:46 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:5302 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030282AbWJDEnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 00:43:45 -0400
Date: Tue, 3 Oct 2006 21:43:29 -0700
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: sekharan@us.ibm.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, winget@google.com, mbligh@google.com,
       rohitseth@google.com, jlan@sgi.com, Simon.Derr@bull.net
Subject: Re: [RFC][PATCH 0/4] Generic container system
Message-Id: <20061003214329.222440b6.pj@sgi.com>
In-Reply-To: <6599ad830610031934s41994158o59f1a2e58b1cb45e@mail.gmail.com>
References: <20061002095319.865614000@menage.corp.google.com>
	<1159925752.24266.22.camel@linuxchandra>
	<6599ad830610031934s41994158o59f1a2e58b1cb45e@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> The filesystem was lifted straight from cpuset.c,

The primary author of the cpuset file system code was Simon Derr.

I'd encourage you to include him on the cc list of future posts of
this patch set.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
