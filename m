Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTJOSqv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbTJOSp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:45:28 -0400
Received: from hugin.maersk-moller.net ([193.88.237.237]:8582 "EHLO
	hugin.maersk-moller.net") by vger.kernel.org with ESMTP
	id S264009AbTJOSos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:44:48 -0400
Message-ID: <3F8D959F.9070908@maersk-moller.net>
Date: Wed, 15 Oct 2003 20:44:47 +0200
From: Peter Maersk-Moller <peter@maersk-moller.net>
Organization: Visit <http://www.maersk-moller.net/>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx lockup for SMP for 2.4.22
References: <3F8D1377.3060509@maersk-moller.net> <3F8D3A47.1000804@maersk-moller.net> <Pine.LNX.4.53.0310151124180.2328@montezuma.fsmlabs.com> <3F8D8690.9040104@maersk-moller.net> <Pine.LNX.4.53.0310151435310.2328@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.53.0310151435310.2328@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Zwane Mwaikambo wrote:
> On Wed, 15 Oct 2003, Peter Maersk-Moller wrote:
>>Assuming UP means uni-processor, do you then mean removing
>>one of the processors or just disabling (ie. not enabling) SMP ?
>>The latter case (enabling IO-APIC and disabling SMP) makes the
>>boot process halt when it come to activating the aic7xxx driver.
> Thanks that's what i wanted to find out, which 2.4 kernel version does it 
> work with?

Hmmm ...... It has worked with 2.4.20 ..... but I just went
through many hardware and software updates and replacements and I
can't (hardware replaced) go back and verify everything ... so I can't
really give you a reliable answer here.

I can try to install everything again in a way that will make it fail
with 2.4.22 and then download and install older versions until it
works again, but that will be a tedious process that will take
many hours of work. Maybe, but only maybe, I'll do it, but only
if you find it VERY useful.

Kind regards

----------------------------------------------------------------
Peter Maersk-Moller
----------------------------------------------------------------
Ogg/Vorbis support for MPEG4IP. YUV12, XviD, AVI and MP4 support
for libmpeg2. See http://www.maersk-moller.net/projects/
----------------------------------------------------------------

