Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTLLWcY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 17:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTLLWbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 17:31:51 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:31363 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262092AbTLLWb3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 17:31:29 -0500
Date: Fri, 12 Dec 2003 22:31:28 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing HZ (patch for HZ > 1000)
Message-ID: <20031212223128.GA15935@mail.shareable.org>
References: <F760B14C9561B941B89469F59BA3A84702C931A4@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84702C931A4@orsmsx401.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:
> I'd advocate lower HZ. Say, oh I dunno...100? This is better for power
> management and also should make the sound go away.

Alas, the sound my Toshiba laptop makes when the CPU is busy is the
same frequency whatever kernel, and by extension whatever the timer
frequency.  I guess it must have another cause :/

-- Jamie
