Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUGISOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUGISOq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 14:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbUGISOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 14:14:45 -0400
Received: from palrel13.hp.com ([156.153.255.238]:35539 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265161AbUGISOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 14:14:42 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16622.57487.724904.777454@napali.hpl.hp.com>
Date: Fri, 9 Jul 2004 11:14:39 -0700
To: Peter Martuccelli <peterm@redhat.com>
Cc: davidm@hpl.hp.com, akpm@osdl.org, faith@redhat.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       ray.lanza@hp.com
Subject: Re: [PATCH] Updated IA64 audit support
In-Reply-To: <200407091401.i69E1lUf005545@redrum.boston.redhat.com>
References: <200407091401.i69E1lUf005545@redrum.boston.redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 9 Jul 2004 10:01:47 -0400, Peter Martuccelli <peterm@redhat.com> said:

  Peter> I updated the patch to use the IS_IA32_PROCESS() macro, and
  Peter> removed trailing white-space as requested.  Retested with the
  Peter> changes, no issues to report. An updated patch follows.  Let
  Peter> me know if there are any other issues.

  Peter> Please CC me directly with with any follow up posts.

Nice and clean.  All that's missing is a changelog entry and a
"Signed-off-by" trailer.  If you send me that, I'll apply it.

Thanks,

	--david
