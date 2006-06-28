Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWF1FpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWF1FpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWF1FpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:45:23 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:29931 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964860AbWF1FpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:45:22 -0400
Date: Tue, 27 Jun 2006 22:44:33 -0700
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       ak@suse.de, drepper@redhat.com, roland@redhat.com, jakub@redhat.com
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
Message-Id: <20060627224433.fb726e0c.pj@sgi.com>
In-Reply-To: <20060621081539.GA14227@elte.hu>
References: <200606210329_MC3-1-C305-E008@compuserve.com>
	<20060621081539.GA14227@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> but my gut feeling is that we should add a proper sys_get_cpu() syscall 

Yes - this should be for more or less all arch's.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
