Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266133AbRGXX0o>; Tue, 24 Jul 2001 19:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266129AbRGXX0d>; Tue, 24 Jul 2001 19:26:33 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:14084 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S266123AbRGXX0R>; Tue, 24 Jul 2001 19:26:17 -0400
Date: Wed, 25 Jul 2001 01:23:34 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Nico Schottelius <nicos@pcsystems.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ps2/ new data for mouse protocol (fwd msg attached)
Message-ID: <20010725012334.L23404@arthur.ubicom.tudelft.nl>
In-Reply-To: <3B5DB12D.2B9C205E@pcsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B5DB12D.2B9C205E@pcsystems.de>; from nicos@pcsystems.de on Tue, Jul 24, 2001 at 07:32:29PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, 2001 at 07:32:29PM +0200, Nico Schottelius wrote:
> Have a look into the attached email before reading mine, please.
> 
> Is it possible to find out about what those bytes are ?
> And is it possible to intergrate the support for other
> 3 bytes into the Linux kernel ?

So they put information about four buttons in six bytes and call that
proprietary? ROFL! How hard can it be? I think it will be fairly
straight forward to reverse engineer the format, it can't be rocket
science.


Erik

> From: "Fidel Zawde" <fzawde@synaptics.com>
> To: <nicos@pcsystems.de>
> Date: Thu, 15 Mar 2001 10:21:22 -0800
> Subject: FW: informations needed of touchpad
> 
> Hello,
> 
> In order to use four buttons the data packages must be larger than the
> standard 3 bytes.  The data packages that the touchpad sends in absolute
> mode is 6 bytes.  The information on how the buttons are inserted into the 6
> byte packet is proprietary.  However, if you would like more information on
> the data packets that are sent from the touchpad you can download the
> "Synaptics Touchpad Interfacing guide" from our website www.synaptics.com.
 

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
