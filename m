Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVAMQ1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVAMQ1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVAMQUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:20:48 -0500
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:16551
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S261673AbVAMQSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:18:09 -0500
Message-ID: <41E69F40.10607@bio.ifi.lmu.de>
Date: Thu, 13 Jan 2005 17:18:08 +0100
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andres Salomon <dilinger@voxel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-as1
References: <1105605448.7316.13.camel@localhost>	 <41E648D4.1050906@bio.ifi.lmu.de> <1105629960.9553.4.camel@localhost>
In-Reply-To: <1105629960.9553.4.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andres Salomon wrote

> My plan is to include security fixes for a kernel or two behind what is
> the latest.  Currently, I'm supporting (for Debian) 2.6.8 through

That would definitely help a lot. I always try to upgrade to a new major
release, but sometimes this is not easy. We have 60 hosts here and are,
for example, using Ati Radeons and nvidia Gforce cards. So when 2.6.10
came out, I couldn't just upgrade until patches came out that made
the fglrx and nv modules compile and work again.

So from time to time, there are reasons to stay with the former major
release for a while (and if it is only because one currently doesn't
have time for testing the new one) and I'm sure that I'm not the only
one with this problem. If at least one kernel behind the latest was
supplied with security fixes that would give people enough time to
test the new release without ruffle while still getting security
fixes for the former release.

> I do not plan to continue small bugfixes for older kernels too much
> longer after a new kernel is released; however, if people were to feed
> me patches for older kernels, I'd be more than happy to do releases.

I guess that for most people security fixes would already be enough,
or say, that's at least what you want in the first place...


I hope that many people make use of this tree and that is will be
included on the kernel.org page as official tree. It definitely is
a very useful tree!

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
