Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbULWKFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbULWKFK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 05:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbULWKFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 05:05:10 -0500
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:64268 "EHLO
	smtp-vbr6.xs4all.nl") by vger.kernel.org with ESMTP id S261198AbULWKFF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 05:05:05 -0500
Date: Thu, 23 Dec 2004 11:05:08 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: selvakumar nagendran <kernelselva@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: insmod error - Invalid module format
Message-ID: <20041223100508.GA21657@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20041223085451.40473.qmail@web60610.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041223085451.40473.qmail@web60610.mail.yahoo.com>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: selvakumar nagendran <kernelselva@yahoo.com>
Date: Thu, Dec 23, 2004 at 12:54:51AM -0800
> Hi,
>    I tried out the simple hello world example module
> present in lkmpg.txt (linux module programming guide)
> on linux kernel 2.6.9. But I got an error while I
> tried to load the created .o file using insmod as
>  ' Invalid Module format'
>  Can anyone help me regarding this?
> 
Normal modules for 2.6.x use .ko as extension, so an .o would be wrong.

Did you check google? lkmpg.txt may be outdated.

Good luck,
Jurriaan
-- 
A woman whose voice and esp could combine to to scramble a man's
thoughts was an impressive guard. Unless, of course, the burglar
happens to be a deaf mute...
	Simon R Green - Mistworld
Debian (Unstable) GNU/Linux 2.6.10-rc3 2x6078 bogomips load 0.16
