Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312695AbSCVGjN>; Fri, 22 Mar 2002 01:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312697AbSCVGiz>; Fri, 22 Mar 2002 01:38:55 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:27358 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S312695AbSCVGid>; Fri, 22 Mar 2002 01:38:33 -0500
Message-ID: <3C9AD0EB.C56CE9B7@veritas.com>
Date: Fri, 22 Mar 2002 12:06:27 +0530
From: "Amit S. Kale" <akale@veritas.com>
Organization: Veritas Software (India)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Hari Gadi <HGadi@ecutel.com>, linux-kernel@vger.kernel.org
Subject: Re: module (kernel) debugging
In-Reply-To: <AF2378CBE7016247BC0FD5261F1EEB210B6A93@EXCHANGE01.domain.ecutel.com> <20020322000823.GD785@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Thu, Mar 21, 2002 at 05:15:48PM -0500, Hari Gadi wrote:
> > Hi,
> > I am new to kernel level development. What are the best ways to debug
> > runtime kernel (module). Are there any third party tools for debugging
> > the kernel.
> 
> http://www.arium.com
> http://oss.sgi.com/projects/kdb
> http://oss.sgi.com/projects/kgdb

SGI's kgdb is for 2.2 kernels only.
kgdb for 2.4 kernels resides at http://kgdb.sourceforge.net/
You'll find there scripts for debugging modules with kgdb.

> http://lkcd.sourceforge.net
> http://bochs.sourceforge.net
> 
> ... and other simulators with debugging support.
> 
> Cheers,
> Bill
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Amit Kale
Veritas Software India ( http://www.veritasindia.com/ )
