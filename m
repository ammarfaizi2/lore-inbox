Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264115AbTFPSZL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTFPSZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:25:11 -0400
Received: from [62.29.77.86] ([62.29.77.86]:2441 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S264115AbTFPSZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:25:06 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: Harald Dunkel <harri@synopsys.COM>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.71, fbconsole: No boot logo?
Date: Mon, 16 Jun 2003 21:39:30 +0300
User-Agent: KMail/1.5.9
References: <3EEE015A.8080601@Synopsys.COM>
In-Reply-To: <3EEE015A.8080601@Synopsys.COM>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200306162139.30224.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> I haven't played with 2.5.x kernels for quite some time, so
> maybe I missed something, but shouldn't there be a penguin
> logo at boot time? AFAICT I have enabled vesa framebuffer,
> fbconsole, and a 224 colors boot logo. The first few lines
> are not scrolled at boot time, but Tux is gone.
>
Try  Graphics support  --->Logo configuration  --->[*] Bootup logo

Regards,
/ismail
