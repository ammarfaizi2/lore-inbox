Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264150AbVBDXTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264150AbVBDXTe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266347AbVBDW7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:59:33 -0500
Received: from ws6-2.us4.outblaze.com ([205.158.62.197]:5866 "HELO
	ws6-2.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263113AbVBDWgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:36:00 -0500
From: Shaw <shaw@vranix.com>
Reply-To: shaw@vranix.com
To: John M Flinchbaugh <john@hjsoft.com>
Subject: Re: 2.6.11-rc3: intel8x0 alsa outputs no sound
Date: Fri, 4 Feb 2005 14:35:46 -0800
User-Agent: KMail/1.7.2
References: <20050204213337.GA12347@butterfly.hjsoft.com>
In-Reply-To: <20050204213337.GA12347@butterfly.hjsoft.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502041435.46221.shaw@vranix.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Friday 04 February 2005 01:33 pm, you wrote:
> i'm using a thinkpad r40 w/ intel8x0 sound card.  it worked with 2.6.10.
> % ogg123 -d alsa09 file.ogg
> i can get no sound through either alsa or oss emulation.

I'm running 2.6.11-rc3 on a T30 also with an intel8x0 card and not 
experiencing any troubles with sound. (Using Alsa, btw)  Did you check the 
usual culprits- that your modules are being loaded, permissions 
of /dev/sound/*, that the channels are unmuted, etc?  Checkout the thinkpad 
list too, they're always very helpful.

Good luck,
Shaw
