Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280572AbRKOS41>; Thu, 15 Nov 2001 13:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280993AbRKOS4R>; Thu, 15 Nov 2001 13:56:17 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:35083 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S280572AbRKOS4C>; Thu, 15 Nov 2001 13:56:02 -0500
Date: Thu, 15 Nov 2001 19:55:53 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin McWhorter <m_mcwhorter@prairiegroup.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible Bug: 2.4.14 USB Keyboard
Message-ID: <20011115195553.A8410@suse.cz>
In-Reply-To: <3BF2DFBF.6090502@prairiegroup.com> <20011114145312.A6925@kroah.com> <3BF3D029.7070609@prairiegroup.com> <20011115090023.A10511@kroah.com> <3BF40C03.4010509@prairiegroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BF40C03.4010509@prairiegroup.com>; from m_mcwhorter@prairiegroup.com on Thu, Nov 15, 2001 at 12:40:03PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 12:40:03PM -0600, Martin McWhorter wrote:
> Greg,
> 
> Sorry I had a think-o. I sent you the info on the wrong kernel.

Do you have the keybdev module loaded? Also, don't load the usbkbd
module, if you load hid ...

-- 
Vojtech Pavlik
SuSE Labs
