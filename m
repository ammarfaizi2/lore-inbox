Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751645AbWCAE0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbWCAE0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 23:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbWCAE0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 23:26:49 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:17801 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751645AbWCAE0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 23:26:48 -0500
Date: Tue, 28 Feb 2006 20:26:32 -0800
From: Paul Jackson <pj@sgi.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: akpm@osdl.org, laurent.riffard@free.fr, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl, mbligh@mbligh.org,
       clameter@engr.sgi.com
Subject: Re: 2.6.16-rc5-mm1
Message-Id: <20060228202632.cba12ae7.pj@sgi.com>
In-Reply-To: <m1wtfepzpu.fsf@ebiederm.dsl.xmission.com>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr>
	<20060228162157.0ed55ce6.akpm@osdl.org>
	<20060228190535.41a8c697.pj@sgi.com>
	<m1wtfepzpu.fsf@ebiederm.dsl.xmission.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> The logic is can I access this file in some other way besides through
> /proc.
> 
> When applied to /proc/<pid>/exe
> When applied to /proc/<pid>/root
> When applied to /proc/<pid>/cwd

I can't make sense of the above.  Could you elaborate?

And explain how any of these permission checks fail for
a root shell?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
