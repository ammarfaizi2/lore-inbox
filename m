Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265246AbUAYUjf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 15:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUAYUjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 15:39:35 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:32918 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S265243AbUAYUjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 15:39:32 -0500
From: Marco Rebsamen <mrebsamen@swissonline.ch>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Troubles Compiling 2.6.1 on SuSE 9
Date: Sun, 25 Jan 2004 21:43:34 +0100
User-Agent: KMail/1.5.4
References: <200401242137.34881.mrebsamen@swissonline.ch> <200401251827.23510.mrebsamen@swissonline.ch> <20040125195500.GB5810@mars.ravnborg.org>
In-Reply-To: <20040125195500.GB5810@mars.ravnborg.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401252143.34292.mrebsamen@swissonline.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 25. Januar 2004 20:55 schrieben Sie:
> > I get many messages:
> > modprobe: modprobe: Can't open dependencies file /lib/
> > modules/2.4.21-99-default/modules.dep (no such file or dir.)
>
> Strange, you are building a 2.6 kernel.
> Did you execute this as root?
>
> 	Sam

originaly i read this on the Kernelmessages console (alt+F10)
but i also tried it as root.... the same...

i've never installed the default kernel. The athlond kernel was installed from 
the beginning. If i make a symlink in this folder that points to the 
modules.dep in the 2.6.1 dir. then it works. But i guess that isn't a clean 
solution.....

fu*** suse or stupid user ?? :-P

