Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265662AbTGDDPn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 23:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265665AbTGDDPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 23:15:43 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:8870 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265662AbTGDDPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 23:15:42 -0400
Date: Thu, 3 Jul 2003 23:30:09 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Brian Ristuccia <bristucc@sw.starentnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rmap15j: sometimes processes stuck in state D, WCHAN
 'down'
In-Reply-To: <20030703124813.GN24907@sw.starentnetworks.com>
Message-ID: <Pine.LNX.4.44.0307032329190.8098-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jul 2003, Brian Ristuccia wrote:

> Is anyone else seeing this problem with stock 2.4.21 or 2.4.21-rmap15j?

I haven't heard of anything like this.  Could you please get
a backtrace of all the stuck processes with alt+sysrq+t and
decode the backtraces with ksymoops ?

thanks,

Rik
-- 
Great minds drink alike.

