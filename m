Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbSJRWAb>; Fri, 18 Oct 2002 18:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265340AbSJRWAb>; Fri, 18 Oct 2002 18:00:31 -0400
Received: from almesberger.net ([63.105.73.239]:1286 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S261559AbSJRWAa>; Fri, 18 Oct 2002 18:00:30 -0400
Date: Fri, 18 Oct 2002 17:03:46 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: suparna@in.ibm.com, fastboot@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: kexec for 2.5.42
Message-ID: <20021018170346.D14894@almesberger.net>
References: <20021016230311.A3447@in.ibm.com> <m1k7ki2qed.fsf@frodo.biederman.org> <20021017150542.A1978@in.ibm.com> <m1elap30nq.fsf_-_@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1elap30nq.fsf_-_@frodo.biederman.org>; from ebiederm@xmission.com on Thu, Oct 17, 2002 at 02:55:05AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> O.k. My first pass at getting up to date with the current kernel is
> available at:

Yipee! I was already having nightmares that we'd have to live
without it for another major kernel release cycle.

I had a quick glance at it, and it looks quite lovely. You
want to get rid of the load_elf_kernel prototype in
include/linux/kexec.h, though :-)

Thanks,
- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
