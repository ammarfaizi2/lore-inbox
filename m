Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTLSJun (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 04:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbTLSJun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 04:50:43 -0500
Received: from holomorphy.com ([199.26.172.102]:29334 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262188AbTLSJuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 04:50:40 -0500
Date: Fri, 19 Dec 2003 01:50:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alexander Poquet <atp@csbd.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 fails to complete boot - Sony VAIO laptop
Message-ID: <20031219095036.GH31393@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alexander Poquet <atp@csbd.org>, linux-kernel@vger.kernel.org
References: <20031219093021.50D9E1E030CA3@csbd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031219093021.50D9E1E030CA3@csbd.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19, 2003 at 09:40:32AM +0000, Alexander Poquet wrote:
> I downloaded and compiled the stock 2.6.0 kernel (no patches applied) and
> attempted to get it to boot on my Sony VAIO laptop (which is running Debian
> testing).  I followed the instructions in README and checked all the relevant
> software in Documentation/Changes; I believe I'm doing everything
> correctly.  I always compile my own kernel.
> Initially, it appeared to not get passed the Loading Linux.... phase;
> the screen would simply blank.  Setting vga=normal however
> demonstrated that the kernel does in fact begin to boot before
> becoming unresponsive; however, the screen still blanks and does so
> too quickly for me to see any relevant printks.

Could you post your lilo.conf and/or grub.conf and /etc/fstab?


-- wli
