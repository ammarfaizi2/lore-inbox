Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262594AbRE3E5R>; Wed, 30 May 2001 00:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262596AbRE3E5H>; Wed, 30 May 2001 00:57:07 -0400
Received: from [208.48.139.185] ([208.48.139.185]:42457 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S262594AbRE3E4x>; Wed, 30 May 2001 00:56:53 -0400
Date: Tue, 29 May 2001 21:56:47 -0700
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5 still breaks dhcpcd with 8139too
Message-ID: <20010529215647.A3955@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

dhcpcd is still broken in 2.4.5 when using the stock 8139too driver as
referenced in this thread:
http://marc.theaimsgroup.com/?t=98847229700003&w=2&r=1

Going back to the 8139too driver in 2.4.3 fixes it.

I see that Alan has reverted back to the 2.4.3 driver for his ac-series for
other reasons, hopefully either the old driver will going in to 2.4.6 or the 
new one will get fixed?

-Dave
