Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270229AbRIMMWS>; Thu, 13 Sep 2001 08:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270271AbRIMMWB>; Thu, 13 Sep 2001 08:22:01 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:8811 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S270174AbRIMMV4>; Thu, 13 Sep 2001 08:21:56 -0400
Date: Thu, 13 Sep 2001 08:21:49 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: Jan Niehusmann <jan@gondor.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
        VDA <VDA@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: Stomping on Athlon bug
Message-ID: <20010913082149.B20967@devserv.devel.redhat.com>
In-Reply-To: <17613305632.20010913121304@port.imtp.ilyichevsk.odessa.ua> <3BA087CA.3BD1D557@redhat.com> <20010913141937.A1873@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010913141937.A1873@gondor.com>; from jan@gondor.com on Thu, Sep 13, 2001 at 02:19:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2001 at 02:19:38PM +0200, Jan Niehusmann wrote:
> On Thu, Sep 13, 2001 at 11:17:46AM +0100, Arjan van de Ven wrote:
> > Interesting; This is exactly the bit that the athlon cool thingy that
> > popped up
> > here a while ago changed; everybody agreed that it was WAAAAY too
> > dangerous
> > back then, because PSU's and voltage regulators wouldn't be able to
> > cope......
> 
> But, as far as I understand, STPGNT will not be enabled unless ACPI
> power saving is in use, so setting the disconnect on STPGNT bit should
> not matter.

That is incorrect; it works perferctly well without ACPI.


-- 
The secret to success is knowing who to blame for your failures.





