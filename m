Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQLRWLy>; Mon, 18 Dec 2000 17:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129810AbQLRWLp>; Mon, 18 Dec 2000 17:11:45 -0500
Received: from quattro.sventech.com ([205.252.248.110]:23050 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S129410AbQLRWLb>; Mon, 18 Dec 2000 17:11:31 -0500
Date: Mon, 18 Dec 2000 16:41:03 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Heitzso <xxh1@cdc.gov>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: usb broken in 2.4.0 test 12 versus 2.2.18
Message-ID: <20001218164101.D1627@sventech.com>
In-Reply-To: <B7F9A3E3FDDDD11185510000F8BDBBF2019C79D3@mcdc-atl-5.cdc.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <B7F9A3E3FDDDD11185510000F8BDBBF2019C79D3@mcdc-atl-5.cdc.gov>; from Heitzso on Mon, Dec 18, 2000 at 04:33:26PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2000, Heitzso <xxh1@cdc.gov> wrote:
> I have a Canon usb camera that I access via a
> recent copy of the s10sh program (with -u option).
> 
> Getting to the camera via s10sh -u worked through 
> large sections of 2.4.0 test X but broke recently.  
> I cannot say for certain which test/patch the 
> break occurred in.
> 
> Running 2.4.0 test12 malloc errors appear.
> Everything is fine with 2.2.18.  I haven't tried
> the test13 series of patches.  
> 
> key .config options:
>  CONFIG_USB on
>  DEVICEFS on
>  HOTPLUG on
>  UHCI on
> everything else off (i.e. printers, keyboards,
> mice, etc.). 
> 
> Baseline system is RH6.2 with most patches applied
> (so avoiding RH7 compiler problems).  Basic dev
> environment is same (i.e. compiling the two kernels
> on the same box).
> 
> If someone wants to email me a debug sequence or
> ask more specific questions feel free.

Could you give us the exact error message you saw?

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
