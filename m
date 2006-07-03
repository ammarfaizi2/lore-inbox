Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWGCSIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWGCSIA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 14:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWGCSIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 14:08:00 -0400
Received: from gw.goop.org ([64.81.55.164]:26311 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932073AbWGCSH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 14:07:59 -0400
Message-ID: <44A95D0F.5090406@goop.org>
Date: Mon, 03 Jul 2006 11:08:15 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andy Gay <andy@andynet.net>
CC: Greg KH <gregkh@suse.de>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Ken Brush <kbrush@gmail.com>
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
 transfers
References: <1151646482.3285.410.camel@tahini.andynet.net>	<adad5cnderb.fsf@cisco.com> <1151872141.3285.486.camel@tahini.andynet.net>	<20060703170040.GA15315@suse.de> <1151949329.3285.545.camel@tahini.andynet.net>
In-Reply-To: <1151949329.3285.545.camel@tahini.andynet.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Gay wrote:
> Aha, good news. So this patch is already obsolete, for the Sierra stuff
> anyway. And as I only have Sierra kit to work with, I reckon I should
> drop out of this now.
> I did make some changes to the last patch to do the cleanup stuff in the
> open function, do you want to see those?
>   
The Sierra driver as it stands is very bare-bones; it doesn't yet have 
the larger buffers.  So for now, I'll keep using the airprime one until 
sierra gets up to speed (though it seems like they should have a fair 
amount of common code).

    J
