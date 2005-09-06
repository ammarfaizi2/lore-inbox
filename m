Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbVIFJd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbVIFJd1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 05:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbVIFJd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 05:33:27 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:56071 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S964776AbVIFJd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 05:33:27 -0400
Date: Tue, 6 Sep 2005 11:33:23 +0200 (CEST)
From: gl@dsa-ac.de
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: input/touchscreen (was Re: who sets boot_params[].screen_info.orig_video_isVGA?)
In-Reply-To: <Pine.LNX.4.63.0509061052080.11341@pcgl.dsa-ac.de>
Message-ID: <Pine.LNX.4.63.0509061131020.11341@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0509051646480.11341@pcgl.dsa-ac.de>
 <E1ECIub-00088O-00@chiark.greenend.org.uk> <Pine.LNX.4.63.0509051736420.11341@pcgl.dsa-ac.de>
 <431CEEAF.5090701@gmail.com> <Pine.LNX.4.63.0509060918310.11341@pcgl.dsa-ac.de>
 <431D5442.1030002@gmail.com> <Pine.LNX.4.63.0509061052080.11341@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2005, gl@dsa-ac.de wrote:

> it. So far so good. Now to my actual task - touchscreen... We are using 
> UR7HCTS2-FG from Semtech. As I cat /dev/input/ts0 and touch the screen, some

Ok, looks like it is not really supported by the stock kernel... Any 
pointers to wild patches? It should be pretty easy to write one, if we had 
a datasheet...

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
