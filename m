Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266469AbRHAKl1>; Wed, 1 Aug 2001 06:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266507AbRHAKlS>; Wed, 1 Aug 2001 06:41:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2058 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266469AbRHAKlC>;
	Wed, 1 Aug 2001 06:41:02 -0400
Date: Wed, 1 Aug 2001 11:41:05 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Per Jessen <per.jessen@enidan.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-laptop@vger.kernel.org" <linux-laptop@vger.kernel.org>
Subject: Re: PCMCIA control I82365 stops working with 2.4.4
Message-ID: <20010801114105.A26615@flint.arm.linux.org.uk>
In-Reply-To: <3B5D8A0A002D181A@mta2n.bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B5D8A0A002D181A@mta2n.bluewin.ch>; from per.jessen@enidan.com on Wed, Aug 01, 2001 at 12:40:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2001 at 12:40:01PM +0200, Per Jessen wrote:
> I have since moved on to 2.4.5, 2.4.6 and 2.4.7 - the i82365 is
> still not being detected. Should I be talking to Toshiba about this ?
> Not having the i82365 module loaded means not being able to use my
> PCMCIA network card - pretty bad situation. 

Use the yenta module instead of the i82365 module.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

