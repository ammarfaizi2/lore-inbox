Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130427AbQLRWbi>; Mon, 18 Dec 2000 17:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130584AbQLRWb2>; Mon, 18 Dec 2000 17:31:28 -0500
Received: from 4dyn46.com21.casema.net ([212.64.95.46]:21777 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S130427AbQLRWbT>;
	Mon, 18 Dec 2000 17:31:19 -0500
Date: Mon, 18 Dec 2000 23:00:24 +0100
From: bert hubert <ahu@ds9a.nl>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: usb broken in 2.4.0 test 12 versus 2.2.18
Message-ID: <20001218230024.A20322@home.ds9a.nl>
Mail-Followup-To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <B7F9A3E3FDDDD11185510000F8BDBBF2019C79D3@mcdc-atl-5.cdc.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <B7F9A3E3FDDDD11185510000F8BDBBF2019C79D3@mcdc-atl-5.cdc.gov>; from xxh1@cdc.gov on Mon, Dec 18, 2000 at 04:33:26PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2000 at 04:33:26PM -0500, Heitzso wrote:
> I have a Canon usb camera that I access via a
> recent copy of the s10sh program (with -u option).
> 
> Getting to the camera via s10sh -u worked through 
> large sections of 2.4.0 test X but broke recently.  
> I cannot say for certain which test/patch the 
> break occurred in.

It works for me (s100), at least on my laptop. I do note that it gives
timeouts if the computer is busy otherwise.

gphoto2 isn't able to retrieve images using recent 2.4.0testX kernels, I
haven't tried earlier kernels yet. It is able to list filenames though.

Regards,

bert hubert

-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
