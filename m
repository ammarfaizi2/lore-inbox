Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264851AbUGNX3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbUGNX3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 19:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbUGNX3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 19:29:00 -0400
Received: from main.gmane.org ([80.91.224.249]:53145 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264851AbUGNX27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 19:28:59 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Volker Braun <volker.braun@physik.hu-berlin.de>
Subject: Re: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
Date: Wed, 14 Jul 2004 19:28:53 -0400
Message-ID: <pan.2004.07.14.23.28.53.135582@physik.hu-berlin.de>
References: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com> <1089054013.15671.48.camel@dhcppc4> <pan.2004.07.06.14.14.47.995955@physik.hu-berlin.de> <slrncfb55n.dkv.jgoerzen@christoph.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: carrot.hep.upenn.edu
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Cc: linux-thinkpad@linux-thinkpad.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2004 20:16:55 +0000, John Goerzen wrote:
> And, if I would shine
> a bright light on the screen, I could make out text on it.  In other
> words, the backlight was off but it was still displaying stuff.

I cannot reproduce that (T41), but maybe I'm looking at the wrong angle or
your eyes are better. In any case I understand that this image is very
faint.

I'm not sure whether this is actually part of the problem. The
liquid crystals might just keep their current orientation, or there might
be some residual charge in the driver circuit. Do you want to take your
display apart and check with a voltmeter? I dont't :-)

Best,
Volker


