Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262760AbSIPRz7>; Mon, 16 Sep 2002 13:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262766AbSIPRz7>; Mon, 16 Sep 2002 13:55:59 -0400
Received: from rzfoobar.is-asp.com ([217.11.194.155]:8623 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id <S262760AbSIPRz7>;
	Mon, 16 Sep 2002 13:55:59 -0400
Message-ID: <3D861C51.4D7AF687@isg.de>
Date: Mon, 16 Sep 2002 20:00:49 +0200
From: Peter Niemayer <niemayer@isg.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, aaronl@vitelus.com, reiser@namesys.com
Subject: Re: ext3 throughput woes on certain (possibly heavily fragmented) files
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

> Sometimes it is best to confess that one does not have the expertise 
> appropriate for answering a question. Someone on our mailing list 
> studied it carefully though. Perhaps they can comment. 

You can find all about the diploma thesis Constantin Loizides
wrote on that topic under

 http://www.informatik.uni-frankfurt.de/~loizides/reiserfs/

Alas, while fragmentation effects are measurable, their real-world-impact
is so heavily masked by even the slightest differences in the VFS of
different Linux kernel versions and the usage pattern of applications
that it is hard to make a definitive general statement.

Regards,

Peter Niemayer
