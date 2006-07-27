Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbWG0NbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbWG0NbB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 09:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161073AbWG0NbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 09:31:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23479 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161071AbWG0Na7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 09:30:59 -0400
Subject: Re: [Ext2-devel] Question about ext3 jbd module
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Mao, Bibo" <bibo.mao@intel.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <CA502B3E9EE27B4490C87C12E3C7C85111D033@pdsmsx412.ccr.corp.intel.com>
References: <CA502B3E9EE27B4490C87C12E3C7C85111D033@pdsmsx412.ccr.corp.intel.com>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 14:30:33 +0100
Message-Id: <1154007033.4941.2.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-07-25 at 17:59 +0800, Mao, Bibo wrote:
> Yes, kernel version is 2.6.9, it is OS distribution kernel RHEL4.

Which version?  There were a few upstream problems like this fixed in
2.6.11 or so, and I think current RHEL-4 updates should include those.

I'm off on holiday/family wedding tomorrow for a couple of weeks, so
replies might be slow...

--Stephen


