Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264199AbUEMNyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264199AbUEMNyg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 09:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264206AbUEMNyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 09:54:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37042 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264199AbUEMNyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 09:54:33 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, rddunlap@osdl.org,
       davidm@hpl.hp.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
References: <m17jvhoa6g.fsf@ebiederm.dsl.xmission.com>
	<20040512143233.0ee0405a.rddunlap@osdl.org>
	<16546.41076.572371.307153@napali.hpl.hp.com>
	<20040512152815.76280eac.akpm@osdl.org>
	<16546.42537.765495.231960@napali.hpl.hp.com>
	<20040512161603.44c50cec.akpm@osdl.org>
	<20040513053051.A5286@infradead.org>
	<m1lljwsvxr.fsf@ebiederm.dsl.xmission.com>
	<20040513083306.A6631@infradead.org>
	<20040513003727.4026699a.akpm@osdl.org>
	<20040513084931.A6858@infradead.org>
	<20040513010427.0e4fe22c.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 May 2004 07:52:34 -0600
In-Reply-To: <20040513010427.0e4fe22c.akpm@osdl.org>
Message-ID: <m17jvge8nx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have no plans to change this API.  It has been reviewed and agreed upon.
At some point we might run into a problem where the flag field is needed
but currently it is a must be zero field.

Eric
