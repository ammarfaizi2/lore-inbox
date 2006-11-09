Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754732AbWKIGYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbWKIGYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 01:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754744AbWKIGYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 01:24:41 -0500
Received: from koto.vergenet.net ([210.128.90.7]:29330 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1754732AbWKIGYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 01:24:41 -0500
Date: Thu, 9 Nov 2006 15:21:24 +0900
From: Horms <horms@verge.net.au>
To: yhlu <yinghailu@gmail.com>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Kexec with latest kernel fail
Message-ID: <20061109062124.GB28415@verge.net.au>
References: <5986589C150B2F49A46483AC44C7BCA49071BF@ssvlexmb2.amd.com> <20061109054805.GA28415@verge.net.au> <2ea3fae10611082204k5316379fsd33a33954c58ab4b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea3fae10611082204k5316379fsd33a33954c58ab4b@mail.gmail.com>
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 10:04:53PM -0800, yhlu wrote:
> On 11/8/06, Horms <horms@verge.net.au> wrote:
> >On Wed, Nov 08, 2006 at 08:07:22PM -0800, Lu, Yinghai wrote:
> >Its largely dependant on what architecture you are using.
> >But try out kexec-tools-testing if you are not already doing so.
> >It is available via git from www.kernel.org/git
> It seems kexec-tools-testing can not be compiled.

That is news to me, as I compiled it myself for all supported
architectures just yesterday.  What problem are you seeing?

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

