Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVAMLGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVAMLGW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 06:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVAMLEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 06:04:16 -0500
Received: from venus.vidconference.de ([212.227.158.183]:27087 "EHLO
	baldur.vidconference.de") by vger.kernel.org with ESMTP
	id S261591AbVAMK5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:57:45 -0500
Message-ID: <41E65427.1020808@vidsoft.de>
Date: Thu, 13 Jan 2005 11:57:43 +0100
From: Gregor Jasny <jasny@vidsoft.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Linux 2.6.10 OOPS
References: <41E63A75.1020107@vidsoft.de> <s5hzmzda9iu.wl@alsa2.suse.de>
In-Reply-To: <s5hzmzda9iu.wl@alsa2.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
>>After removing an USB webcam with a built-in microphone (snd-usb-audio)
>>the kernel oopsed and the PS/2 keyboard wasn't working anymore.
> 
> Yeah this is a known problem.  This seems to be introduced recently.
> IIRC, it didn't happen with the USB stack on 2.6.9.

At least on Fedora Core 3 with 2.6.9-1.667 it is happening, too.
 From a posting on the PWC mailing list:

 > I'm using FC3 with kernel version  2.6.9-1.667 and no other
 > usb devices (in fact no other external devices) on a an
 > ibm thinkpad t42 laptop.
