Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTISNjU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 09:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbTISNjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 09:39:20 -0400
Received: from gw-nl5.philips.com ([212.153.235.109]:41602 "EHLO
	gw-nl5.philips.com") by vger.kernel.org with ESMTP id S261566AbTISNjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 09:39:19 -0400
Message-ID: <3F6B0760.20905@basmevissen.nl>
Date: Fri, 19 Sep 2003 15:40:48 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How does one get paid to work on the kernel?
References: <1063915370.2410.12.camel@laptop-linux> <yw1xad91nrmd.fsf@users.sourceforge.net> <1063958370.5520.6.camel@laptop-linux> <yw1xu179mc55.fsf@users.sourceforge.net>
In-Reply-To: <yw1xu179mc55.fsf@users.sourceforge.net>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:

> 
> I see.  BTW, is it possible to boot normally, and later resume from
> the saved state, provided you don't touch any filesystems or swap
> areas involved in the suspend?  I seem to recall reading somewhere
> that it would be possible, but I can't find any information on how to
> do it.
> 

Just wondering: what kind of use do you see for that?

ctually, I'm more thinking of a sort of freezing the state of processes 
rather then the kernel state. It would be nice to generalise this to be 
able to quick-(re)start applications (as long as their config file 
aren't changed).

Bas.



