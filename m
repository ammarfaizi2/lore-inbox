Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVFKRRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVFKRRd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 13:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVFKRRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 13:17:32 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:47572 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261749AbVFKRR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 13:17:28 -0400
Date: Sat, 11 Jun 2005 19:17:20 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Assuming NULL
In-Reply-To: <yw1x64wkkfeb.fsf@ford.inprovide.com>
Message-ID: <Pine.LNX.4.61.0506111916390.22504@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0506111823440.19223@yvahk01.tjqt.qr>
 <yw1x64wkkfeb.fsf@ford.inprovide.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>And a third:
>
>- in some places it's safe to assume non-NULL, but not always
>  => then we need to check only the unsafe places

Fine, it would be nice to know where in my module (providing a filesystem) I 
can assume something and where not. (And not only my module.)



Jan Engelhardt                                                               
--                                                                            
| Gesellschaft fuer Wissenschaftliche Datenverarbeitung Goettingen,
| Am Fassberg, 37077 Goettingen, www.gwdg.de
