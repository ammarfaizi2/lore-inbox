Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129072AbRBLXbM>; Mon, 12 Feb 2001 18:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129075AbRBLXbC>; Mon, 12 Feb 2001 18:31:02 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:64006 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129072AbRBLXan>; Mon, 12 Feb 2001 18:30:43 -0500
Date: Tue, 13 Feb 2001 12:30:38 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Ivan Passos <lists@cyclades.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: LILO and serial speeds over 9600
Message-ID: <20010213123038.B18818@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.31.0102121147390.25638-100000@lairdtest1.internap.com> <Pine.LNX.4.10.10102121456380.3761-100000@main.cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10102121456380.3761-100000@main.cyclades.com>; from lists@cyclades.com on Mon, Feb 12, 2001 at 03:17:04PM -0800
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2001 at 03:17:04PM -0800, Ivan Passos wrote:

    Then HPA may ask: but why do you want to run the serial console
    at 115200?? The answer is simple: because we can (or more
    precisely, because the HW can ;).

Actually... consider debugging PCI hardware on a large SMP box; you
get lots of kernel messages and even reboot is slowed by the volume
you see there.

There you want as fast a console as you can possibly have...



  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
