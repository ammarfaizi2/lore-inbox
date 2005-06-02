Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVFBQuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVFBQuk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 12:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVFBQuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 12:50:40 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:20624 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261195AbVFBQuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 12:50:35 -0400
Date: Thu, 2 Jun 2005 12:50:34 -0400
To: Ananda Krishnan <veedutwo@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Did anyone try (Logitech/Microsoft) bluetooth keyboard and mouse on Linux?
Message-ID: <20050602165034.GP23621@csclub.uwaterloo.ca>
References: <20050602163740.37068.qmail@web14824.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050602163740.37068.qmail@web14824.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 09:37:40AM -0700, Ananda Krishnan wrote:
>   Did anyone try Logitech/Microsoft wireless keyboard
> and mouse on Linux?  If so, please let me have the
> details of the driver you used and the details of the
> keyboard/mouse (model number, brand etc.,).  Thanks.

Well in my opinion, if anyone makes a keyboard/mouse that does not use
standard protocols and work without any custom drivers, they are going
to fail badly.

Certainly the logitech cordless mouse/keyboard set I have (not
bluetooth) just appears as a usb mouse and keyboard (or optionally ps/2
mouse and keyboard if you use the other connectors) to the system and
work with no special drivers required other than what you normally use
for mouse and keyboard on that type of connector.

If you want to do networking or something over bluetooh, that is
different, but that isn't what mouse/keyboard should require unless
bluetooth was never meant to be used for such things.  Not sure why you
want bluetooth for the mouse/keyboard.  Doesn't it use the same
frequency range as 802.11b/g?  I don't need more interference around the
machine in that frequency range.

Len Sorensen
