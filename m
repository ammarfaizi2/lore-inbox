Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWEOMvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWEOMvt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 08:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWEOMvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 08:51:49 -0400
Received: from smtp10.wanadoo.fr ([193.252.22.21]:31706 "EHLO
	smtp10.wanadoo.fr") by vger.kernel.org with ESMTP id S1750801AbWEOMvs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 08:51:48 -0400
X-ME-UUID: 20060515125148497.0C1B724001BD@mwinf1012.wanadoo.fr
Subject: RE: GPL and NON GPL version modules
From: Xavier Bestel <xavier.bestel@free.fr>
To: "Nutan C." <nutanc@esntechnologies.co.in>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>,
       Fawad Lateef <fawadlateef@gmail.com>, jjoy@novell.com,
       "Mukund JB." <mukundjb@esntechnologies.co.in>, gauravd.chd@gmail.com,
       bulb@ucw.cz, greg@kroah.com, Shakthi Kannan <cyborg4k@yahoo.com>,
       "Srinivas G." <srinivasg@esntechnologies.co.in>
In-Reply-To: <AF63F67E8D577C4390B25443CBE3B9F7092931@esnmail.esntechnologies.co.in>
References: <AF63F67E8D577C4390B25443CBE3B9F7092931@esnmail.esntechnologies.co.in>
Content-Type: text/plain
Message-Id: <1147697493.25330.77.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 15 May 2006 14:51:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 14:12, Nutan C. wrote:
> Hi Jan,
> 
> So, if the proprietary code exposes an interface and if the code within
> the GPL makes a call to that interface, will the proprietary code become
> part of GPL. Please suggest

No, but you don't have permission to redistribute the resulting kernel
unless the whole code is GPL.
In short, you can make it but you can't ship it.

	Xav


