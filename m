Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136848AbREJQpS>; Thu, 10 May 2001 12:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136847AbREJQpI>; Thu, 10 May 2001 12:45:08 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:13232 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S136845AbREJQo7>;
	Thu, 10 May 2001 12:44:59 -0400
Message-ID: <3AFAC589.60D676CB@mandrakesoft.com>
Date: Thu, 10 May 2001 12:44:57 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam <adam@vbfx.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 8139too v0.9.17 - w/ 8139B, DFE538TX 10/100 [NOT working]
In-Reply-To: <3AFAC3E2.6BA7D8C0@vbfx.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam wrote:
> Is the exact message I get, though, with the v0.9.15c version of the
> driver, my NIC works perfectly fine, should I revert to using kernel
> 2.4.3 w/ v0.9.15c of the 8139too driver until it is fixed?

Well, if it doesn't work you pretty much have to revert to the older
working version. :(

Working on a fix...

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
