Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWIGK2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWIGK2Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 06:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWIGK2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 06:28:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18903 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751393AbWIGK2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 06:28:22 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060906232045.GA9744@us.ibm.com> 
References: <20060906232045.GA9744@us.ibm.com>  <20060904225419.GA4367@us.ibm.com> <20060830211203.GA12953@us.ibm.com> <20060825221615.GA11613@us.ibm.com> <20060824182044.GE17658@us.ibm.com> <20060824181722.GA17658@us.ibm.com> <22796.1156542677@warthog.cambridge.redhat.com> <27154.1156546746@warthog.cambridge.redhat.com> <10689.1157020231@warthog.cambridge.redhat.com> <8777.1157535885@warthog.cambridge.redhat.com> 
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] eCryptfs: ino_t to u64 for filldir 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 07 Sep 2006 11:28:11 +0100
Message-ID: <29962.1157624891@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Michael Halcrow <mhalcrow@us.ibm.com> wrote:

> How's this?

Looks good.

Acked-By: David Howells <dhowells@redhat.com>
