Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVACXFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVACXFY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVACXDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:03:46 -0500
Received: from main.gmane.org ([80.91.229.2]:38085 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261925AbVACXDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:03:00 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ben Pfaff <blp@cs.stanford.edu>
Subject: Re: [3/8] kill gen_init_cpio.c printk() of size_t warning
Date: Mon, 03 Jan 2005 15:03:02 -0800
Message-ID: <87oeg6t8t5.fsf@benpfaff.org>
References: <20050103172013.GA29332@holomorphy.com> <41D9881B.4020000@pobox.com>
 <20050103180915.GK29332@holomorphy.com>
 <Pine.LNX.4.61.0501031329030.13385@chaos.analogic.com>
 <crccas$la0$1@terminus.zytor.com> <20050103213627.GS29332@holomorphy.com>
 <20050103215503.GX26051@parcelfarce.linux.theplanet.co.uk>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-6-66-193.client.comcast.net
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:jtLmsUnhD0Wa/LjOBrLmxVAysTQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@parcelfarce.linux.theplanet.co.uk> writes:

> Egads...  Just use %zd for size_t.

%zu?

