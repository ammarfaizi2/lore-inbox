Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVB0DXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVB0DXZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 22:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVB0DXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 22:23:24 -0500
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:7324 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261337AbVB0DXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 22:23:22 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Frank Victor Fischer <celestar@t-online.de>
Subject: Re: ALPS touchpad not seen by 2.6.11 kernels
Date: Sat, 26 Feb 2005 22:23:17 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200502262355.13559.celestar@t-online.de>
In-Reply-To: <200502262355.13559.celestar@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502262223.18107.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 February 2005 17:55, Frank Victor Fischer wrote:
> I have had the same problem and the solution worked for me as well.
> 
> Where should I put the DSDT?
> 

Just e-mail it to me - I suspect your PS/2 port has a wierd ID assigned
to it, one that i8042 driver does not expect.

-- 
Dmitry
