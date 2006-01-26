Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWAZO1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWAZO1b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWAZO1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:27:31 -0500
Received: from mail.cs.tut.fi ([130.230.4.42]:60877 "EHLO mail.cs.tut.fi")
	by vger.kernel.org with ESMTP id S932338AbWAZO1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:27:30 -0500
Date: Thu, 26 Jan 2006 16:27:24 +0200
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060126142723.GQ17268@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5zc5f-6pi-3@gated-at.bofh.it>
User-Agent: Mutt/1.5.9i
From: shd@modeemi.cs.tut.fi (Heikki Orsila)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> People like to run cdrecord -scanbus in order to find a list of usable 
> devices. People like to see all SCSI devices in a single name space as 
> they are all using the same protocol for communication.

Not me. I would just like to see a list of /dev/name entries, rather 
than know anything about scsi. Better yet, I wouldn't want to know 
anything about the devices. It should just work.

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
