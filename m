Return-Path: <linux-kernel-owner+w=401wt.eu-S965062AbWL2Rs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbWL2Rs6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 12:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWL2Rs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 12:48:58 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:35717 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965062AbWL2Rs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 12:48:57 -0500
Message-ID: <4595552C.6050001@yahoo.fr>
Date: Fri, 29 Dec 2006 18:49:32 +0100
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Marc Haber <mh+linux-kernel@zugschlus.de>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
References: <1166314399.7018.6.camel@localhost> <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost> <20061217154026.219b294f.akpm@osdl.org> <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org> <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org> <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org> <45861E68.3060403@yahoo.com.au> <20061217214308.62b9021a.akpm@osdl.org> <20061219085149.GA20442@torres.l21.ma.zugschlus.de> <20061228180536.GB7385@torres.zugschlus.de> <Pine.LNX.4.64.0612281014190.4473@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612281014190.4473@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds a écrit :
> going back to Linux-2.6.5 at least, according to one tester).
>   

I apologize for the confusion, but it just occurred to me that I was 
actually
experiencing a totally different problem: I set a root filesystem of 
3Mib for
qemu, so the test program just didn't have enough space for its file.

-- 
Guillaume

