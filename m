Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131274AbRCMXse>; Tue, 13 Mar 2001 18:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131273AbRCMXsW>; Tue, 13 Mar 2001 18:48:22 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:22790 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S131269AbRCMXsM>; Tue, 13 Mar 2001 18:48:12 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Message-ID: <86256A0E.0082A102.00@smtpnotes.altec.com>
Date: Tue, 13 Mar 2001 17:46:38 -0600
Subject: Re: Linux 2.4.2ac20
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've just noticed with 2.4.2-ac20 that /proc/sys/fs/binfmt_misc is no longer
being created.  I have CONFIG_BINFMT_MISC=y in my .config.  This was working
fine in 2.4.3-pre4.

Wayne


