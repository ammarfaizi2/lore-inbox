Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272437AbTGaIbn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 04:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272438AbTGaIbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 04:31:43 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:58629 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S272437AbTGaIbm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 04:31:42 -0400
Date: Thu, 31 Jul 2003 01:31:39 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030731083139.GN14240@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <200307301608.h6UG8YQJ000339@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307301608.h6UG8YQJ000339@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message is may contain confidential information.  Unauthorised disclosure will be prosecuted to the fullest extent of the law.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 05:08:34PM +0100, John Bradford wrote:
> I'll buy some LEDs and build a parallel port connected LED panel
> tomorrow...  Do you think the overhead of driving the LEDs would have
> too much of a negative effect on system performance?  If so, or if we
> want more flexibility, maybe we could work out a design for a PCI
> card, which could include more than 12 LEDs - 7-segment numeric
> displays of pid, etc.

If you are going to talk special hardware i'd suggest making
it a USB device instead of a PCI card.

Most systems manufactured in the last five years or so ago
have USB but laptops don't and many servers don't have a
spare PCI slot.  There is enough power specified by the
standard to make it a passive device in most cases.  If you
want you could use a cable long enough to mount the display
on the wall outside the wiring closet or server room.

Sounds fun so have some.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
