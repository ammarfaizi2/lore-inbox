Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265762AbTFSKrH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 06:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265763AbTFSKrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 06:47:07 -0400
Received: from WebDev.iNES.RO ([80.86.100.174]:50055 "EHLO webdev.ines.ro")
	by vger.kernel.org with ESMTP id S265762AbTFSKrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 06:47:05 -0400
Date: Thu, 19 Jun 2003 14:01:03 +0300 (EEST)
From: Andrei Ivanov <andrei.ivanov@ines.ro>
X-X-Sender: shadow@webdev.ines.ro
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 warning in 2.5.70
In-Reply-To: <Pine.LNX.4.56L0.0306191354250.27610@webdev.ines.ro>
Message-ID: <Pine.LNX.4.56L0.0306191400260.27610@webdev.ines.ro>
References: <Pine.LNX.4.56L0.0306191354250.27610@webdev.ines.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sorry, that is 2.5.72-mm1

On Thu, 19 Jun 2003, Andrei Ivanov wrote:

> 
> I left the computer doing updates and I found lots of warnings in the 
> morning on the console:
> 
> EXT3-fs warning (device hda3): dx_probe: Unrecognised inode hash code 28
> 
> the logs says the message was repetead 625 times.
> 
> I forced a fsck on the fs, but no error was found.
> 
> Should I worry ?
> 
