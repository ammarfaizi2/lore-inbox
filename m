Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265139AbUD3KvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUD3KvG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 06:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264823AbUD3KvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 06:51:06 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:15783 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265139AbUD3KvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 06:51:04 -0400
Date: Fri, 30 Apr 2004 11:50:19 +0100
From: Dave Jones <davej@redhat.com>
To: zhangjg <zhangjg@ict.ac.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] kernel 2.4.18 kupdate BUG report
Message-ID: <20040430105019.GA25695@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	zhangjg <zhangjg@ict.ac.cn>, linux-kernel@vger.kernel.org
References: <000001c43186$a7630680$060f0a0a@zhangjg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c43186$a7630680$060f0a0a@zhangjg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 11:19:47AM +0800, zhangjg wrote:
 > When I running redhat 8.0(2.4.18-14 kernel)

1. Red Hat bugs go to http://bugzilla.redhat.com
2. Except in this case, you're running a distro that's
   reached end of life, so is unsupported.
3. There were a few dozen errata kernels after that kernel
   that you should try. The last 8.0 kernel was something
   like 2.4.20-24 or so.. Googling for the Fedora legacy
   project should also find you backports of the RHL9 kernels
   that were done after the end of life of RHL 8.0

		Dave

