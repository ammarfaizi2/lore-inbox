Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTJVRCd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 13:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTJVRCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 13:02:33 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:32531 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263486AbTJVRCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 13:02:32 -0400
Date: Wed, 22 Oct 2003 18:02:30 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Jurriaan <thunder7@xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8-mm1
In-Reply-To: <20031021185326.GA1558@middle.of.nowhere>
Message-ID: <Pine.LNX.4.44.0310221801390.25125-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 2.6.0-test8 + this patch boots perfectly here:

Cool :-)
 
> kernel /boot/vmlinuz-260test8fb root=/dev/md3 video=matroxfb:xres:1600,yres:1360,depth:16,pixclock:4116,left:304,right:64,upper:46,lower:1,hslen:192,vslen:3,fv:90,hwcursor=off hdd=scsi atkbd_softrepeat=1
> 
> This configuration didn't boot in 2.6.0-test8-mm1 (screen stayed in
> 80x25 VGA mode and it crashed before the mode-switch).

:-( I wonder if it has to do with the debugging code discussed in the 
other emails.


