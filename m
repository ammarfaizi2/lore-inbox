Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272132AbTHDSmB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272130AbTHDSmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:42:01 -0400
Received: from trained-monkey.org ([209.217.122.11]:22798 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S272128AbTHDSlz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:41:55 -0400
To: davidm@hpl.hp.com
Cc: "H. J. Lu" <hjl@lucon.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: milstone reached: ia64 linux builds out of Linus' tree
References: <200308041737.h74HbdCf015443@napali.hpl.hp.com>
	<20030804175308.GB16804@lucon.org>
	<16174.41999.166222.406494@napali.hpl.hp.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 04 Aug 2003 14:41:49 -0400
In-Reply-To: <16174.41999.166222.406494@napali.hpl.hp.com>
Message-ID: <m365ldw9hu.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Mosberger <davidm@napali.hpl.hp.com> writes:

>>>>> On Mon, 4 Aug 2003 10:53:08 -0700, "H. J. Lu" <hjl@lucon.org> said:
HJ> Does it work on bigsur?

David> It should, apart from a qla1280.c glitch (see the latest ia64
David> diff for the one-liner to get it to work; Jes Sorensen said
David> he's going to cleanup qla1280 for real).

Yes, I already have in fact. I submitted the updated driver to James
Bottomley for inclusion in the tree. I'll post it to you shortly.

Cheers,
Jes
