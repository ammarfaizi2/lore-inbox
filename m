Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbTDQOF2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbTDQOF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:05:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36294
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261427AbTDQOF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:05:27 -0400
Subject: Re: [PATCH] kill ide-geometry.c, fix boot problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries.Brouwer@cwi.nl
Cc: jamie@shareable.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mbligh@aracnet.com, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <UTC200304162300.h3GN05X17159.aeb@smtp.cwi.nl>
References: <UTC200304162300.h3GN05X17159.aeb@smtp.cwi.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050585547.31414.34.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Apr 2003 14:19:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-17 at 00:00, Andries.Brouwer@cwi.nl wrote:
> But of course, it is easy to add some heuristic code.
> I would prefer to keep such code out of the vanilla kernel,
> but a vendor might want it.
> 
> [And note that todays patch did not remove any DM detection.
> This discussion is 37 patch levels late.]


For Linus tree maybe, but my tree never got rid of the stuff because
I never agreed with you.

