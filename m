Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbVIHTk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbVIHTk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 15:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbVIHTk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 15:40:56 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:11997 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S964963AbVIHTkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 15:40:55 -0400
Date: Thu, 8 Sep 2005 15:40:51 -0400
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       alsa-devel <alsa-devel@alsa-project.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Brand-new notebook useless with Linux...
Message-ID: <20050908194051.GE28578@csclub.uwaterloo.ca>
References: <200509081522_MC3-1-A986-1B52@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509081522_MC3-1-A986-1B52@compuserve.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 03:19:32PM -0400, Chuck Ebbert wrote:
>  What fun is that?  I have learned that HP/Compaq is hostile to Linux,
> for one thing, which was interesting (my system is a Compaq Presario
> V2312US.)

Well they may be hostile but so far no problems with a compaq r3240.
Well the silly TI media card reader is useless, but it's useless in
windows too (who limits cards to 512M these days?).

>  Can you help me find out why my codec is unknown?  I gave up trying to
> figure out how to get the codec ID and hacked the source to print it:
> 
> atiixp: codec 0 not available for modem
> atiixp: no codec available
> ALSA device list:
>   #0 ATI IXP rev 2 with 0x43585430 at 0xd0003400, irq 177
> 
> So it's a Conexant codec with ID 0x30 on an atiixp.  OSS has some support
> for this codec, apparently.

I know I am not going near ati hardware any time soon.

Len Sorensen
