Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVAGFpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVAGFpa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 00:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVAGFpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 00:45:30 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:20154 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261254AbVAGFp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 00:45:26 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Date: Fri, 7 Jan 2005 00:45:24 -0500
User-Agent: KMail/1.6.2
Cc: Roey Katz <roey@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org> <200501052316.48443.dtor_core@ameritech.net> <Pine.NEB.4.61.0501070405170.2840@sdf.lonestar.org>
In-Reply-To: <Pine.NEB.4.61.0501070405170.2840@sdf.lonestar.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501070045.24639.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 January 2005 11:06 pm, Roey Katz wrote:
> Dmitry,
> 
> Bingo!
> 2.6.9-rc2-bk2 worked (where bk3 hadn't before).
> The system responded to keyboard input.
> What's the next step?
> 

I am not quite sure yet. Could you post the boot log of -bk2 with debug
enabled on your web site, please?

-- 
Dmitry
