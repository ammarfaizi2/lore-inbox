Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265397AbTFWJYT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 05:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbTFWJYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 05:24:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36362 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265397AbTFWJYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 05:24:19 -0400
Date: Mon, 23 Jun 2003 10:38:15 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: bvermeul@blackstar.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with PCMCIA/Orinoco
Message-ID: <20030623103815.E23411@flint.arm.linux.org.uk>
Mail-Followup-To: bvermeul@blackstar.nl, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0306171123540.1854-100000@blackstar.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0306171123540.1854-100000@blackstar.nl>; from bvermeul@blackstar.nl on Tue, Jun 17, 2003 at 11:29:00AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 11:29:00AM +0200, bvermeul@blackstar.nl wrote:
> I'm having some problems with 2.5.71 (latest bk yesterday I believe).
> All works well (pcmcia works as advertised, with one tiny blip on
> the horizon), except when I want to reboot, when I get the following
> message:
> 
> unregister_netdevice: waiting for eth1 to become free. Usage count = 1

Is this still an outstanding problem in 2.5.73?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

