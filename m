Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVC0VZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVC0VZq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 16:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVC0VZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 16:25:46 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:4695 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261565AbVC0VZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 16:25:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=cgqPajeV+T4viLBrTRvUjpxXv/yeXU353Nxsi1PfA+h1TZmCRWetc09+qE7Y/CrwLEsdD2vAB9GLIO8VQvFy9U2yDlA9qd49vh1exoZON+lwc3MY8q0JX4PiGSg58qTXCNA6/5x6NXju55tNRKdh0F5FqH5bboi+wKQHXP7RbqA=
Message-ID: <9e47339105032713251c88890@mail.gmail.com>
Date: Sun, 27 Mar 2005 16:25:10 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Adam Belay <abelay@novell.com>
Subject: Re: [RFC] Some thoughts on device drivers and sysfs
Cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
In-Reply-To: <1111951499.3503.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <1111951499.3503.87.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2005 14:24:59 -0500, Adam Belay <abelay@novell.com> wrote:
> This would allow us to represent per-device driver attributes in sysfs.
> As an added benefit, driver devices would allow the tracking and control
> of driver state, which may be needed for dynamic power management.  I
> look forward to any comments.

Isn't there already a way to do this? I recall some discussion lkml
about six months ago  about doing it. I tried googling for it but
couldn't find it. It may not have been implemented.

-- 
Jon Smirl
jonsmirl@gmail.com
