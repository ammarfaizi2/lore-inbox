Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290689AbSARNkz>; Fri, 18 Jan 2002 08:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290690AbSARNkp>; Fri, 18 Jan 2002 08:40:45 -0500
Received: from mailer.zib.de ([130.73.108.11]:49108 "EHLO mailer.zib.de")
	by vger.kernel.org with ESMTP id <S290689AbSARNkf>;
	Fri, 18 Jan 2002 08:40:35 -0500
Date: Fri, 18 Jan 2002 14:40:31 +0100
From: Sebastian Heidl <heidl@zib.de>
To: Ram Shankar <kramsn@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LINUX IP Stack
Message-ID: <20020118134031.GH27177@csr-pc1.zib.de>
Mail-Followup-To: Sebastian Heidl <heidl@zib.de>,
	Ram Shankar <kramsn@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020118131854.44722.qmail@web14604.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020118131854.44722.qmail@web14604.mail.yahoo.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2002 at 05:18:54AM -0800, Ram Shankar wrote:
> We are interested in moving the IP stack into the
> application area. i.e. It should link with our
> application and use the devices (like /dev/eth0) for
> the layer 2 interface.
Have a look at the arsenic project:
http://www.cl.cam.ac.uk/Research/SRG/netos/arsenic/

They've already done it. ;-)

regards,
_sh_

