Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264319AbRFIPGu>; Sat, 9 Jun 2001 11:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264331AbRFIPGj>; Sat, 9 Jun 2001 11:06:39 -0400
Received: from sal.qcc.sk.ca ([198.169.27.3]:9484 "HELO sal.qcc.sk.ca")
	by vger.kernel.org with SMTP id <S264319AbRFIPG3>;
	Sat, 9 Jun 2001 11:06:29 -0400
Date: Sat, 9 Jun 2001 09:06:27 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: temperature standard - global config option?
Message-ID: <20010609090627.D21327@qcc.sk.ca>
In-Reply-To: <9fskv3$niq$1@cesium.transmeta.com> <Pine.SOL.4.33.0106091015470.572-100000@yellow.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.SOL.4.33.0106091015470.572-100000@yellow.csi.cam.ac.uk>; from jas88@cam.ac.uk on Sat, Jun 09, 2001 at 10:17:43AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Sutherland <jas88@cam.ac.uk> wrote:
> 
> The current x86 setup uses a small sensor sitting under the CPU socket.

Current Intel chips have a sensor built right into the die of the processor
itself -- voila, close enough to the critical junction temperature for any
purpose.  Many workstation CPUs have a similar feature, and the other x86
manufacturers either do or have plans to include such a beast.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
Any opinions expressed are just that -- my opinions.
-----------------------------------------------------------------------
