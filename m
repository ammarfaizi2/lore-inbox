Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261810AbSIXV33>; Tue, 24 Sep 2002 17:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261820AbSIXV33>; Tue, 24 Sep 2002 17:29:29 -0400
Received: from smtp020.tiscali.dk ([212.54.64.104]:16876 "EHLO
	smtp020.tiscali.dk") by vger.kernel.org with ESMTP
	id <S261810AbSIXV31>; Tue, 24 Sep 2002 17:29:27 -0400
Date: Tue, 24 Sep 2002 23:33:57 +0200
From: Jacob Gorm Hansen <jg@ioi.dk>
To: Karim Yaghmour <karim@opersys.com>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>,
       Adeos <adeos-main@mail.freesoftware.fsf.org>,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [Adeos-main] Re: [PATCH] Adeos nanokernel for 2.5.38 1/2: no-arch code
Message-ID: <20020924213356.GA14291@ibook>
References: <3D8E8371.D2070D87@opersys.com> <20020922045907.C35@toy.ucw.cz> <3D90D388.746D0C0D@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D90D388.746D0C0D@opersys.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 05:05:12PM -0400, Karim Yaghmour wrote:
> 
> To be honest, nothing in Adeos is "new". Adeos is implemented on
> classic early '90s nanokernel research. I've listed a number of
> nanokernel papers in the paper I wrote on Adeos. A complete list
> of nanokernel papers would probably have hundreds of entries.
> Some of these nanokernels even had OS schedulers (exokernel for
> instance). All Adeos implements is a scheme for sharing the
> interrupts among the various OSes using an interrupt pipeline.

Hi,

are you planning to add spaces & portals, like in Space or Pebble?

best,
Jacob
