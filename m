Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269772AbUJAMsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269772AbUJAMsi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 08:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269775AbUJAMsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 08:48:37 -0400
Received: from rzdspc1.informatik.uni-hamburg.de ([134.100.9.61]:48031 "EHLO
	rzdspc1.informatik.uni-hamburg.de") by vger.kernel.org with ESMTP
	id S269772AbUJAMrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 08:47:32 -0400
Date: Fri, 1 Oct 2004 14:46:43 +0200
From: Axel Gordon Grossklaus <6grosskl@informatik.uni-hamburg.de>
To: Martin Hermanowski <martin@mh57.de>
Cc: Roland Dreier <roland.list@gmail.com>, linux-thinkpad@linux-thinkpad.org,
       linux-kernel@vger.kernel.org
Subject: Re: Hard lockup on IBM ThinkPad T42
Message-ID: <20041001124642.GH5579@rzdspc3.informatik.uni-hamburg.de>
References: <f8ca0a1504093011206230ddea@mail.gmail.com> <20040930205851.GA6911@mh57.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930205851.GA6911@mh57.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 10:58:51PM +0200, Martin Hermanowski wrote:

moin,

> I have lockups in X running xlock with my T41p about once a month,
> running 2.6.7-rc3-mm1 with atheros and the XFree4.3 radeon driver.
> 
> The only thing I noticed is that the hdd-led is constantly on when this
> happens.

i had that problem on my T41p (kernel oops when unlocking xlock, usually
if constant network traffic went on in the back).
updating madwifi to CVS version helped. (i had the version that comes
with suse 9.1 before).

tty, axel


