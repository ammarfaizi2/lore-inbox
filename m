Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313438AbSDPApT>; Mon, 15 Apr 2002 20:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313440AbSDPApS>; Mon, 15 Apr 2002 20:45:18 -0400
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:33219 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S313438AbSDPApR>; Mon, 15 Apr 2002 20:45:17 -0400
Date: Tue, 16 Apr 2002 01:45:01 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: David Rorke <DRORKE@volera.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 and zero copy transmit
Message-ID: <20020416014501.C30169@kushida.apsleyroad.org>
In-Reply-To: <scbb0a8c.058@prv-mail20.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Rorke wrote:
> If there are no plans to add this to eepro100.c, does anyone know if
> the Intel
> provided driver in addon/e100 will be supporting this soon?

There is code in the 2.5.7 e100 driver, if you define E100_ZEROCOPY.  I
don't know if the code works though.

-- Jamie
