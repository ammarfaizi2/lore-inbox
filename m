Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVG1SZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVG1SZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 14:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVG1SXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 14:23:52 -0400
Received: from mail.portrix.net ([212.202.157.208]:47256 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S262126AbVG1SXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 14:23:03 -0400
Message-ID: <42E92280.6070400@ppp0.net>
Date: Thu, 28 Jul 2005 20:22:56 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050602 Thunderbird/1.0.2 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: v850, which gcc and binutils version?
References: <42E78474.8070300@ppp0.net>	<buo64uvit4p.fsf@mctpc71.ucom.lsi.nec.co.jp>	<42E896EC.7030503@ppp0.net> <buoek9jgvxh.fsf@mctpc71.ucom.lsi.nec.co.jp>
In-Reply-To: <buoek9jgvxh.fsf@mctpc71.ucom.lsi.nec.co.jp>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader wrote:
> Jan Dittmer <jdittmer@ppp0.net> writes:
> 
>>>"v850e-elf".
>>
>>Thanks, that got me much further, compilation aborts now with
> 
> 
> Hmmm, what sources are you compiling exactly?

-rc3-mm3; but if the error was no toolchain bug I won't try much further.
The important thing to me was, that my compile tests
now produce somewhat meaningful results for this platform.

> I last tested with 2.6.12 + 2.6.12-uc0 (uClinux) patches + the v850 patches
> I sent to the LKML recently (from which I presume you got the defconfigs);
> the v850 patches should now be merged into Linus's tree, but I dunno about

I suppose your patches don't apply cleanly against 2.6.12-uc0 ?

Thanks,

-- 
Jan

http://l4x.org/k/
