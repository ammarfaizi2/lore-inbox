Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261659AbSI0H37>; Fri, 27 Sep 2002 03:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSI0H37>; Fri, 27 Sep 2002 03:29:59 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:17103 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261659AbSI0H36>; Fri, 27 Sep 2002 03:29:58 -0400
Date: Fri, 27 Sep 2002 03:35:07 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
Cc: "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: Distributing drivers independent of the kernel source tree
Message-ID: <20020927033507.A18387@devserv.devel.redhat.com>
References: <A9713061F01AD411B0F700D0B746CA6802FC14D7@vacho6misge.cho.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <A9713061F01AD411B0F700D0B746CA6802FC14D7@vacho6misge.cho.ge.com>; from Daniel.Heater@gefanuc.com on Thu, Sep 26, 2002 at 05:16:03PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 05:16:03PM -0400, Heater, Daniel (IndSys, GEFanuc, VMIC) wrote:
> 
> That's true for installing modules, but I'm wondering about getting a
> standalone module compiled. I.e., what is a reliable method for locating the
> include files for the kernel?

as I said

/lib/modules/`uname -r`/build/include

