Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288149AbSATKiI>; Sun, 20 Jan 2002 05:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288154AbSATKh6>; Sun, 20 Jan 2002 05:37:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35855 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288149AbSATKh5>; Sun, 20 Jan 2002 05:37:57 -0500
Message-ID: <3C4A9DFA.8070109@zytor.com>
Date: Sun, 20 Jan 2002 02:37:46 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Rainer krienke <rainer@krienke.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com> <200201181212.g0ICCGq14563@bliss.uni-koblenz.de> <a29tms$s9v$1@cesium.transmeta.com> <200201201033.g0KAXfw20121@robotnik.krienke.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rainer krienke wrote:

> 
> You mentioned, you'd probably include this in another V3 release. Does this 
> mean, that V4 already can do this? What syntax is needed? What about the 
> logical/physical path problem? Is this already solved by using vfsbinds in V4?
> 
> Thanks Rainer
> 

I don't know about v4.  You have to ask Jeremy about that.

vfsbinds takes care of any "logical/physical" path problem, so it's not 
an issue there.

	-hpa

