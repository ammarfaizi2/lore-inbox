Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTL3UF2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 15:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265917AbTL3UF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 15:05:28 -0500
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:60893 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S262126AbTL3UFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 15:05:24 -0500
Date: Tue, 30 Dec 2003 13:06:43 -0700
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Is it safe to ignore UDMA BadCRC errors?
Message-ID: <20031230200643.GC6992@bounceswoosh.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us> <20031229195235.GC26821@bounceswoosh.org> <16369.25514.425834.153361@jik.kamens.brookline.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <16369.25514.425834.153361@jik.kamens.brookline.ma.us>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30 at  6:38, Jonathan Kamens wrote:
>I replaced the cable with a brand new one and I'm still getting the
>CRC errors.  What now?

Do you know if you're doing reads or writes when the errors occur?

What motherboard/chipset are you using with this drive?

Is the environment especially warm?

-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

