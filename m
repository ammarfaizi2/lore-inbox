Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265613AbUALSiH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 13:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUALSiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 13:38:07 -0500
Received: from pop.gmx.net ([213.165.64.20]:3210 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265613AbUALShz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 13:37:55 -0500
X-Authenticated: #4512188
Message-ID: <4002E980.3030401@gmx.de>
Date: Mon, 12 Jan 2004 19:37:52 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Allen <the3dfxdude@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm1
References: <20040112175443.GA870@tesore.local>
In-Reply-To: <20040112175443.GA870@tesore.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Allen wrote:
> I didn't think these patches would make it into a kernel tree, except experimental ones.  For one, I don't think we know what's wrong with the nforce2's apic timer.  And second, I don't need the disconnect patch, because I have verfied a BIOS update has fixed C1 disconnect completely for my board. (works on and off)

Isn't is possbile to find out which registers were altered with the new 
bios? Ie. read out registers with out bios and then with new bios adn 
then compare? Then we (well someone smarter than me :)) could make a 
real fix for the nforce2-apic issue.

Prakash
