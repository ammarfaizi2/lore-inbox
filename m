Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVCaFqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVCaFqW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 00:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVCaFqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 00:46:21 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:32904 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261991AbVCaFqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 00:46:19 -0500
Date: Thu, 31 Mar 2005 07:46:03 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Wiktor <victorjan@poczta.onet.pl>
cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] 'nice' attribute for executable files
In-Reply-To: <424B090F.3090508@poczta.onet.pl>
Message-ID: <Pine.LNX.4.61.0503310745430.9253@yvahk01.tjqt.qr>
References: <fa.ed33rit.1e148rh@ifi.uio.no> <E1DGNaV-0005LG-9m@be1.7eggert.dyndns.org>
 <424ACEA9.6070401@poczta.onet.pl> <yw1xpsxhvzsz.fsf@ford.inprovide.com>
 <424AE18B.1080009@poczta.onet.pl> <yw1xll85vtva.fsf@ford.inprovide.com>
 <424B090F.3090508@poczta.onet.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> You could wrap /lib/ld-linux.so, and get all dynamically linked
>> programs done in one sweep.

That does not handle static binaries :)



Jan Engelhardt
-- 
No TOFU for me, please.
