Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293154AbSCEFTi>; Tue, 5 Mar 2002 00:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293164AbSCEFT2>; Tue, 5 Mar 2002 00:19:28 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:60170 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293154AbSCEFTV>;
	Tue, 5 Mar 2002 00:19:21 -0500
Date: Mon, 4 Mar 2002 21:11:46 -0800
From: Greg KH <greg@kroah.com>
To: Carl-Johan Kjellander <carljohan@kjellander.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pwc-webcam attached to usb-ohci card blocks on read() indefinitely.
Message-ID: <20020305051146.GA7075@kroah.com>
In-Reply-To: <3C8419FF.10103@kjellander.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C8419FF.10103@kjellander.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 05 Feb 2002 03:08:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 02:06:07AM +0100, Carl-Johan Kjellander wrote:
> 
> Attached to each one of these is an Philips ToUCam pro which uses the pwc
> and pwcx modules. (yes, the kernel becomes tainted by the pwcx module)

As you are using this closed source module, I suggest you take this up
with that module's author.

Good luck,

greg k-h
