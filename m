Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276381AbRJCPbD>; Wed, 3 Oct 2001 11:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276384AbRJCPao>; Wed, 3 Oct 2001 11:30:44 -0400
Received: from mailf.telia.com ([194.22.194.25]:7124 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S276379AbRJCPa0>;
	Wed, 3 Oct 2001 11:30:26 -0400
Date: Wed, 3 Oct 2001 17:30:52 +0200
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: usb ov511 problem (kernel crash)
Message-ID: <20011003173052.B2337@telia.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110031227510.4235-100000@edu.joroinen.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0110031227510.4235-100000@edu.joroinen.fi>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pasi Kärkkäinen <pasik@iki.fi> wrote:

> I have an HP Omnibook 6000 laptop. When I plug in the D-LINK DRU-100C
> (Ver. B2) usb-camera, and load the ov511 driver, the camera is detected
> just fine. But, when I try to use the /dev/video0, the whole kernel
> crashes!

Try 2.4.11-pre2. The changelog says "Greg KH: USB updates", and I think
that includes a fix for a crasher that a few people have run into. I
think it was in usb-uhci.

Hope this helps,
-- 

André Dahlqvist <andre.dahlqvist@telia.com>
