Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbUELWJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUELWJz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 18:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUELWJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 18:09:55 -0400
Received: from palrel13.hp.com ([156.153.255.238]:53920 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261580AbUELWJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 18:09:49 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16546.41076.572371.307153@napali.hpl.hp.com>
Date: Wed, 12 May 2004 15:08:52 -0700
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: ebiederm@xmission.com (Eric W. Biederman), drepper@redhat.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm <akpm@osdl.org>
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
In-Reply-To: <20040512143233.0ee0405a.rddunlap@osdl.org>
References: <20040511212625.28ac33ef.rddunlap@osdl.org>
	<40A1AF53.3010407@redhat.com>
	<m13c66qicb.fsf@ebiederm.dsl.xmission.com>
	<40A243C8.401@redhat.com>
	<m1brktod3f.fsf@ebiederm.dsl.xmission.com>
	<40A2517C.4040903@redhat.com>
	<m17jvhoa6g.fsf@ebiederm.dsl.xmission.com>
	<20040512143233.0ee0405a.rddunlap@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 12 May 2004 14:32:33 -0700, "Randy.Dunlap" <rddunlap@osdl.org> said:

  Randy> I don't know when vdso will be available (for non-x86[2]) or

  Randy> [2] kexec is currently only available for x86, but there is interest
  Randy> in it for ia64 and ppc64 at least.

ia64 does have VDSO (and has had it for some time).

I quite like Uli's idea.

	--david
