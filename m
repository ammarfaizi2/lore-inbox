Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262744AbTCVN0W>; Sat, 22 Mar 2003 08:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262750AbTCVN0W>; Sat, 22 Mar 2003 08:26:22 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38297
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262744AbTCVN0V>; Sat, 22 Mar 2003 08:26:21 -0500
Subject: Re: 2.5.65-mm3 bad: scheduling while atomic! [SCSI]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <87el4z1sq3.fsf@lapper.ihatent.com>
References: <20030320235821.1e4ff308.akpm@digeo.com>
	 <87el4z1sq3.fsf@lapper.ihatent.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048344561.8912.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2003 14:49:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-22 at 12:38, Alexander Hoogerhuis wrote:
> Andrew Morton <akpm@digeo.com> writes:
> > 
> > [SNIP]
> > 
> 
> Here's a few more funnies caught while burning a CD:

ide-scsi is known broken in 2.5, and will stay that way for a little
while yet I suspect. I sent Linus the infrastructure needed to fix
it yesterday.

