Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVIINbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVIINbr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 09:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbVIINbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 09:31:47 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:35712 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750810AbVIINbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 09:31:45 -0400
Date: Fri, 9 Sep 2005 06:31:31 -0700
From: Paul Jackson <pj@sgi.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: magnus.damm@gmail.com, kurosawa@valinux.co.jp, dino@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] SUBCPUSETS: a resource control functionality using
 CPUSETS
Message-Id: <20050909063131.64dc8155.pj@sgi.com>
In-Reply-To: <20050909.203849.33293224.taka@valinux.co.jp>
References: <20050909013804.1B64B70037@sv1.valinux.co.jp>
	<aec7e5c305090821126cea6b57@mail.gmail.com>
	<20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takahashi-san wrote:
> What do you think if you make cpusets for sched domain be able to
> have their siblings, which have the same attribute and share
> their resources between them.

I do not understand this question.  I guess "cpusets for sched
domains" means "cpusets whose 'cpu_exclusive' attribute is
marked true, but which have no child cpusets so marked."

But even that guess I am unsure of, and the rest of the sentence
"which have the same ..." I don't even have a guess what means.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
