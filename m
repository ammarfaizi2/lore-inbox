Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbVIHTWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbVIHTWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 15:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbVIHTWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 15:22:54 -0400
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:40067 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964939AbVIHTWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 15:22:54 -0400
Date: Thu, 8 Sep 2005 15:19:32 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Brand-new notebook useless with Linux...
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200509081522_MC3-1-A986-1B52@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1125805091.14032.69.camel@mindpipe>

On Sat, 03 Sep 2005 at 23:38:10 -0400, Lee Revell wrote:

> On Sat, 2005-09-03 at 18:58 -0400, Chuck Ebbert wrote:
> > I just bought a new notebook.
> 
> I'd return it if I were you.

 What fun is that?  I have learned that HP/Compaq is hostile to Linux,
for one thing, which was interesting (my system is a Compaq Presario
V2312US.)

 Can you help me find out why my codec is unknown?  I gave up trying to
figure out how to get the codec ID and hacked the source to print it:


atiixp: codec 0 not available for modem
atiixp: no codec available
ALSA device list:
  #0 ATI IXP rev 2 with 0x43585430 at 0xd0003400, irq 177


So it's a Conexant codec with ID 0x30 on an atiixp.  OSS has some support
for this codec, apparently.


__
Chuck
