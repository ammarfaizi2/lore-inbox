Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTIYHWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 03:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbTIYHUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 03:20:12 -0400
Received: from pD95069B7.dip.t-dialin.net ([217.80.105.183]:54532 "EHLO
	command.earth.ufp") by vger.kernel.org with ESMTP id S261748AbTIYHTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 03:19:54 -0400
Subject: Re: 2.6.0-test5-mm3 Promise SuperTrak SX6000 unrecognized
From: Juergen Sawinski <george@mpimf-heidelberg.mpg.de>
To: Dave Poirier <dave.poirier@atrium.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <fc.008695730061456b008695730061456b.6145b2@atrium.ca>
References: <fc.008695730061456b008695730061456b.6145b2@atrium.ca>
Content-Type: text/plain
Message-Id: <1064474599.11158.3.camel@voyager.earth.ufp>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 25 Sep 2003 09:23:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://lkml.org/lkml/2003/2/4/138
(and other threads)

--> 2) In the BIOS of the card, set it to "Other OS', not Linux
--> 3) Disable support for Promise cards in Linux

George

On Wed, 2003-09-24 at 23:49, Dave Poirier wrote:
> I have a Promise SuperTRAK SX6000 IDE RAID controller card which, no
> matter which options are set in the kernel, fail to be recognized.  I
> tried with 2.4.22, 2.6.0-test1..test5 and 2.6.0-test5-mm3, all of which
> simply seems to ignore the card altogether.


