Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWFLW1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWFLW1e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 18:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWFLW1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 18:27:34 -0400
Received: from gw.goop.org ([64.81.55.164]:43216 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750793AbWFLW1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 18:27:33 -0400
Message-ID: <448DEA4E.7000707@goop.org>
Date: Mon, 12 Jun 2006 15:27:26 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC] maxSize option for usb-serial to increase max endpoint
 buffer size
References: <447DFBC5.70200@goop.org> <20060531203803.GA7735@suse.de>
In-Reply-To: <20060531203803.GA7735@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> I've been working with Ken on getting this driver to work better
> (meaning faster).  Here's the latest version (without your new device id
> added).  Care to test it out and let me know if it works or not?
>   
I've been exercising this fairly heavily for the last few hours, and it 
looks pretty solid - no problems at all.

    J
