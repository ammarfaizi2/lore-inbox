Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279874AbRKBAJp>; Thu, 1 Nov 2001 19:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279876AbRKBAJe>; Thu, 1 Nov 2001 19:09:34 -0500
Received: from jalon.able.es ([212.97.163.2]:17575 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S279874AbRKBAJS>;
	Thu, 1 Nov 2001 19:09:18 -0500
Date: Fri, 2 Nov 2001 01:09:06 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord from ext3 [jamagallon@able.es]
Message-ID: <20011102010906.E12958@werewolf.able.es>
In-Reply-To: <20011031001846.A1840@werewolf.able.es> <3BDF576F.3A797933@zip.com.au> <20011031155934.A18608@werewolf.able.es> <200110311752.JAA06153@cesium.transmeta.com> <20011031192425.A1757@werewolf.able.es> <3BE04AA3.7010303@zytor.com> <20011102010824.C12958@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20011102010824.C12958@werewolf.able.es>; from jamagallon@able.es on Fri, Nov 02, 2001 at 01:08:24 +0100
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011102 J . A . Magallon wrote:

On 20011031 H. Peter Anvin wrote:
>
>
>That might work, although you might also have primed the cache; I would do
>a reboot in between.
>

I'm redoing the tests to post the numbers, but my question is one other:
could a sysct/proc-entry be added to force a cache cleanup ? I, say to kernel
'clean all the pages that are just cache'...much like sync dumps buffers.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.14-pre6-beo #4 SMP Thu Nov 1 17:30:48 CET 2001 i686
