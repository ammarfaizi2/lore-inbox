Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbTJ1TZQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 14:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbTJ1TZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 14:25:16 -0500
Received: from palrel13.hp.com ([156.153.255.238]:28898 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261592AbTJ1TZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 14:25:13 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16286.49814.27138.219567@napali.hpl.hp.com>
Date: Tue, 28 Oct 2003 11:25:10 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org
Subject: Re: status of ipchains in 2.6?
In-Reply-To: <20031028095747.2cdb57e7.davem@redhat.com>
References: <200310280127.h9S1RM5d002140@napali.hpl.hp.com>
	<20031028015032.734caf21.davem@redhat.com>
	<16286.44522.275791.73904@napali.hpl.hp.com>
	<20031028095747.2cdb57e7.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 28 Oct 2003 09:57:47 -0800, "David S. Miller" <davem@redhat.com> said:

  David> On Tue, 28 Oct 2003 09:56:58 -0800 David Mosberger
  David> <davidm@napali.hpl.hp.com> wrote:

  >> >>>>> On Tue, 28 Oct 2003 01:50:32 -0800, "David S. Miller"
  >> <davem@redhat.com> said:

  >> $ fgrep -i ipchain MAINTAINERS

  David> Try netfilter, ipchains is a part of netfilter.

I took ipchains not being mentioned in MAINTAINERS as a sign that
nobody wanted to hear bug reports about it, hence my choice of lkml.
Perhaps you prefer to flame people rather than making it easier
for them to find the right mailing-list?

	--david
