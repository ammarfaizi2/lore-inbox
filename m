Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290681AbSARM1O>; Fri, 18 Jan 2002 07:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290682AbSARM1F>; Fri, 18 Jan 2002 07:27:05 -0500
Received: from mons.uio.no ([129.240.130.14]:58557 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S290681AbSARM0w>;
	Fri, 18 Jan 2002 07:26:52 -0500
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com>
	<200201171855.g0HIt1314492@devserv.devel.redhat.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 18 Jan 2002 13:26:41 +0100
In-Reply-To: <200201171855.g0HIt1314492@devserv.devel.redhat.com>
Message-ID: <shs8zav975q.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Pete Zaitcev <zaitcev@redhat.com> writes:

     > Anyone cares to review? Trond? Viro?

Have you discussed the choice of device number with hpa
(device@lanana.org)?  Although the numbers you chose were marked as
'obsolete', you really ought to ensure that they get reserved.

Otherwise, things look pretty straightforward...

Cheers,
   Trond
