Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTFIV20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTFIV0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:26:47 -0400
Received: from air-2.osdl.org ([65.172.181.6]:50571 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262135AbTFIV0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:26:08 -0400
Date: Mon, 9 Jun 2003 14:41:23 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New system device API
In-Reply-To: <20030609213247.GC508@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0306091440360.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Oh and btw keyboard controller is used for rebooting machine. Do you
> still say it is not system device?

BFD. So is the power cable and reset button. Should we represent those as 
well? 

Pavel, why argue when we could spend more time actually getting stuff to 
wrok? 


	-pat

