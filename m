Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269888AbUJGXD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269888AbUJGXD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269853AbUJGXBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:01:40 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:39850 "EHLO
	mailfe05.swip.net") by vger.kernel.org with ESMTP id S269854AbUJGW4E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:56:04 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Fri, 8 Oct 2004 00:55:59 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, sebastien.hinderer@libertysurf.fr
Subject: Re: [Patch] new serial flow control
Message-ID: <20041007225559.GE2296@bouh.is-a-geek.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Russell King <rmk@arm.linux.org.uk>,
	sebastien.hinderer@libertysurf.fr
References: <200410051249_MC3-1-8B8B-5504@compuserve.com> <20041005172522.GA2264@bouh.is-a-geek.org> <1097176130.31557.117.camel@localhost.localdomain> <20041007214330.GB2296@bouh.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041007214330.GB2296@bouh.is-a-geek.org>
User-Agent: Mutt/1.5.6i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 07 oct 2004 à 23:43:30 +0200, Samuel Thibault a écrit:
> I'm asking because there was some funny bug not that far ago: async
> ppp people thought that xon/xoff were processed in the serial driver,

For some record
http://groups.google.com/groups?threadm=Pine.LNX.4.10.10112042358240.2290-100000@youpi.residence.ens-lyon.fr#link15
and
http://groups.google.com/groups?threadm=Pine.LNX.4.10.10112062257590.1328-100000@youpi.residence.ens-lyon.fr
(google didn't like the subject change)

Regards,
Samuel Thibault
