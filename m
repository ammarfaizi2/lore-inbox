Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTKTIiY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 03:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbTKTIiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 03:38:24 -0500
Received: from ns.schottelius.org ([213.146.113.242]:47550 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S261567AbTKTIiX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 03:38:23 -0500
Date: Thu, 20 Nov 2003 09:38:27 +0100
From: Nico Schottelius <nico-mutt@schottelius.org>
To: Ben Hoskings <ben@jeeves.bpa.nu>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: transmeta cpu code question
Message-ID: <20031120083827.GL3748@schottelius.org>
References: <20031120020218.GJ3748@schottelius.org> <200311201210.04780.ben@jeeves.bpa.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311201210.04780.ben@jeeves.bpa.nu>
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.0-test4
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all guys for your answers, it looks like it was
more obvious I would like to admit.

So to recapitulate it, the and with the 0xff 8-Bit value
with an 32Bit Value let's us cut out values, to cut within
a value 'with a pair of scissors' like this:

0x AA BB CC DD
   |  |  |  |  
   | 0xBB| 0xDD
  0xAA 0xCC

Have a nice day, I will read on the small transmeta code...

I am still interested whether there are possibilities to
   a) use the crusoe without the morphing software (to use its native
      command set)
   b) to fine tune Linux to my specific processor, to make it use all
      available feautures the processor has.

Nico

