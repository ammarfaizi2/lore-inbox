Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVLHO2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVLHO2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVLHO2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:28:13 -0500
Received: from newton.gmurray.org.uk ([81.2.114.237]:55010 "EHLO
	newton.gmurray.org.uk") by vger.kernel.org with ESMTP
	id S932154AbVLHO16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:27:58 -0500
X-DKIM: Sendmail DKIM Filter v0.2.0 newton.gmurray.org.uk jB8ERvWR001315
From: Graham Murray <graham@gmurray.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	<21d7e9970512050339s392c12a9jd4168cd707bb5e8d@mail.gmail.com>
X-Hashcash: 1:22:051208:linux-kernel@vger.kernel.org::tt0Kx1VL9yst30Gz:000000000000000000000000000000000AMS+
Date: Thu, 08 Dec 2005 14:27:56 +0000
In-Reply-To: <21d7e9970512050339s392c12a9jd4168cd707bb5e8d@mail.gmail.com>
	(Dave Airlie's message of "Mon, 5 Dec 2005 22:39:42 +1100")
Message-ID: <87u0djiryr.fsf@newton.gmurray.org.uk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie <airlied@gmail.com> writes:

> ATI engineers now use the excuse well NVIDIA have a closed source
> driver so we have to have one to compete. Again neither company is
> willing to put resources into doing much on the open source scene
> due to lack of staff, reasons, and neither company is willing to
> give info to open source developers because they need to push it all
> past their legal departments (despite this info existing and a
> number of open source developers having access to it via $job).

Maybe one day they might see that having an open source driver, or
even just releasing the hardware interface specifications so that
drivers can be written, will give them an advantage over those who
only have closed source drivers. After all, these companies are in the
business of designing and selling hardware and knowing the interface
specifications (ie the registers and the commands which have to be
sent to them etc) should not give away the layout of the silicon (ie
does not give competitors information about how the commands are
translated to actual operations on the screen). So publishing the
interface should not violate the IP of the silicon design owners.
