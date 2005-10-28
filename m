Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbVJ1H25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbVJ1H25 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbVJ1H24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:28:56 -0400
Received: from [218.25.172.144] ([218.25.172.144]:12560 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S965171AbVJ1H24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:28:56 -0400
Date: Fri, 28 Oct 2005 15:28:47 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: yogeshwar sonawane <yogyas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: deletion of device file from /dev after reboot
Message-ID: <20051028072847.GA3769@localhost.localdomain>
References: <b681c62b0510272359w4ad32bb3p4eba47a33bb030f0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b681c62b0510272359w4ad32bb3p4eba47a33bb030f0@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 12:29:33PM +0530, yogeshwar sonawane wrote:
> hello,
> 
> I am trying a pseudo character driver. But after reboot, my device
> file from /dev directory is getting deleted. This is for 2.6 kernel.
> Is there a way to create a file permanently which will be not deleted
> after reboot? Earlier in 2.4, this was not the case.

udev?
