Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317434AbSHTWO4>; Tue, 20 Aug 2002 18:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSHTWO4>; Tue, 20 Aug 2002 18:14:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12552 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317434AbSHTWOz>; Tue, 20 Aug 2002 18:14:55 -0400
Message-ID: <3D62C039.60206@zytor.com>
Date: Tue, 20 Aug 2002 15:18:33 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: automount doesn't "follow" bind mounts
References: <Pine.LNX.4.44.0208201752430.23681-100000@r2-pc.dcs.qmul.ac.uk> <ajuahu$hf$1@cesium.transmeta.com> <ajucmu$1qd$1@cesium.transmeta.com> <20020820180956.L21269@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Tue, Aug 20, 2002 at 02:35:26PM -0700, H. Peter Anvin wrote:
> 
>>Actually, if you're using autofs v3, which it sounds like you're
>>doing, it's even more broken, since autofs v3 doesn't support
>>multilevel mounts.
> 
> 
> Is there an autofs v4 daemon that's actually released?  The only thing I 
> see is code that's over a year old in /pub/linux/daemons/autofs/testing-v4/ 
> on kernel.org.  If pre10 is okay, it should be released (at least that 
> would explain why we're still shipping v3).
> 

The problem is that autofs v4 is completely unmaintained at the moment.

	-hpa


