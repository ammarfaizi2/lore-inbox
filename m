Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVFKRNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVFKRNm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 13:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVFKRNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 13:13:42 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:27604 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261744AbVFKRNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 13:13:41 -0400
Date: Sat, 11 Jun 2005 19:13:39 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mini_fo-0.6.0 overlay file system
Message-ID: <Pine.LNX.4.61.0506111909520.22504@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


just looked at kerneltraffic to catch up on the past month's dev. Someone also 
mentioned the keyword "unionfs" (
http://marc.theaimsgroup.com/?l=linux-kernel&m=111601844402446&w=2
) in one point, but:

I might point out that there is already a full fledged overlay filesystem
at http://www.fsl.cs.sunysb.edu/project-unionfs.html
It's not really leightweight (approx 120 KB when compiled) but "it's there".


Jan Engelhardt                                                               
--                                                                            
| Gesellschaft fuer Wissenschaftliche Datenverarbeitung Goettingen,
| Am Fassberg, 37077 Goettingen, www.gwdg.de
