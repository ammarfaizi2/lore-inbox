Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751820AbWBXCtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbWBXCtO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 21:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbWBXCtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 21:49:14 -0500
Received: from ns2.suse.de ([195.135.220.15]:49814 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751820AbWBXCtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 21:49:13 -0500
From: Andi Kleen <ak@suse.de>
To: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
Date: Fri, 24 Feb 2006 03:47:47 +0100
User-Agent: KMail/1.9.1
Cc: Dave Jones <davej@redhat.com>, Rene Herman <rene.herman@keyaccess.nl>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <20060223202638.GD6213@redhat.com> <1140749055.2411.14.camel@localhost.localdomain>
In-Reply-To: <1140749055.2411.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602240347.49199.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 03:44, Fernando Luis Vazquez Cao wrote:

> The mkdump team has been using runtime relocatable kernels for two years
> and we are currently working on porting this functionality to kdump. I
> was wondering if it would be accepted mainstream.

The question cannot be answered without a patch to look at.  Just post
it once it works.

-Andi
