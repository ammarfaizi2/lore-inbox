Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289369AbSAaAnH>; Wed, 30 Jan 2002 19:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290775AbSAaAm5>; Wed, 30 Jan 2002 19:42:57 -0500
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:31639 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S289369AbSAaAmq>; Wed, 30 Jan 2002 19:42:46 -0500
Date: Wed, 30 Jan 2002 19:46:34 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre7aa1
Message-ID: <20020131004634.GA160@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Historical changelog for 2.4.18pre7aa1 at:
http://home.earthlink.net/~rwhron/kernel/2.4.18pre7aa1.html

Benchmarks on 2.4.18pre7aa1 and other kernels at:
http://home.earthlink.net/~rwhron/kernel/k6-2-475.html

On Fri, Jan 25, 2002 at 06:29:01PM +0100, Dave Jones wrote:
>  > The -aa kernel seems to contain patches to a few dozen subsystems.
>
>  Agreed. Andrea's tree seemed to gain quite a bit of a lead
>  when bits of the lowlat patches were applied for eg.
>  Just taking 00_vm_?? from ../people/andrea/.. would give better
>  comparison

Several of Andrea's patches touch the core VM files.  Deciding
what to include, and the order to apply them would take some
effort, know how, and good judgement.

If someone provides a list of the patches to apply in the
proper order, I will run the tests.  

-- 
Randy Hron

