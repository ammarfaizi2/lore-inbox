Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbTIPUnS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 16:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbTIPUnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 16:43:18 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:53005 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S262068AbTIPUnS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 16:43:18 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: Bug/Oops Power Management with linux-2.6.0-test5-mm2
Date: Wed, 17 Sep 2003 04:41:46 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, Ramon Casellas <casellas@infres.enst.fr>
References: <Pine.LNX.4.44.0309160949140.26788-100000@cherise>
In-Reply-To: <Pine.LNX.4.44.0309160949140.26788-100000@cherise>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309170441.47559.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 September 2003 00:53, Patrick Mochel wrote:
> Sorry, I missed that line in the logs before. You need HIGHMEM enabled to 
> support the full 1GB of RAM, but the suspend-to-disk code is not prepared 
> to handle high pages yet. It will be addressed, but probably not for 
> another few weeks. 
> 

Would you have an idea if and when the PCI links will be addressed?

Regards
Michael

