Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266134AbUA1ScH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 13:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266131AbUA1ScH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 13:32:07 -0500
Received: from palrel11.hp.com ([156.153.255.246]:39071 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S266128AbUA1ScD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 13:32:03 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16408.30.896895.980121@napali.hpl.hp.com>
Date: Wed, 28 Jan 2004 10:31:58 -0800
To: Andi Kleen <ak@suse.de>
Cc: Grant Grundler <iod00d@hp.com>, ishii.hironobu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 1/4] readX_check() performance evaluation
In-Reply-To: <20040128184137.616b6425.ak@suse.de>
References: <00a201c3e541$c0e7d680$2987110a@lsd.css.fujitsu.com>
	<20040128172004.GB5494@cup.hp.com>
	<20040128184137.616b6425.ak@suse.de>
X-Mailer: VM 7.17 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 28 Jan 2004 18:41:37 +0100, Andi Kleen <ak@suse.de> said:

  Andi> Also in my experience from AMD64 which originally was a bit
  Andi> aggressive on enabling MCEs: enabling MCEs increases your
  Andi> kernel support load a lot.

  Andi> Many people have slightly buggy systems which still happen to
  Andi> work mostly.  If you report every problem you as kernel
  Andi> maintainer will be flooded with reports about things you can
  Andi> nothing to do about.

I find this comment interesting.  Can you elaborate what you mean by
"slightly buggy systems"?

	--david
