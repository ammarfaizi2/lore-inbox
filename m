Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVANICE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVANICE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 03:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVANICE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 03:02:04 -0500
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:15264
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S261647AbVANICA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 03:02:00 -0500
Message-ID: <41E77C76.3070204@bio.ifi.lmu.de>
Date: Fri, 14 Jan 2005 09:01:58 +0100
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gregory Boyce <gboyce@badbelly.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel releases for security updates
References: <Pine.LNX.4.61.0501121340560.20156@buddha.badbelly.com>
In-Reply-To: <Pine.LNX.4.61.0501121340560.20156@buddha.badbelly.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Boyce wrote

> Rather than actually putting out point releases for the previously 
> released kernels, why not just create a centralized repository for the 
> security patches?  In a lot of cases security patches can be applied as is 
> to a number of different kernel revisions.  For the ones that cannot, 
> variances of the patches could be posted along with it clearly marked as 
> to which patches apply to which kernels.
> 
> Thoughts?

I guess the new -as tree is more or less achieving what you want. If
Andres gets enough support from other people, it might be possible to
maintain even more than one or two former releases...

[x] Voting for the -as tree to become an official tree on kernel.org :-)

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
