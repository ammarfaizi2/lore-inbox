Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSFTWcn>; Thu, 20 Jun 2002 18:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSFTWcm>; Thu, 20 Jun 2002 18:32:42 -0400
Received: from jalon.able.es ([212.97.163.2]:51629 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315721AbSFTWck>;
	Thu, 20 Jun 2002 18:32:40 -0400
Date: Fri, 21 Jun 2002 00:31:30 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Doug Ledford <dledford@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AIC7XXX + v2.4.18 problems?
Message-ID: <20020620223130.GA1742@werewolf.able.es>
References: <m3k7ov2tly.fsf@noop.bombay> <20020619214925.GA1739@werewolf.able.es> <20020620151622.D9181@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020620151622.D9181@redhat.com>; from dledford@redhat.com on Thu, Jun 20, 2002 at 21:16:22 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.06.20 Doug Ledford wrote:
>
>No, the order of devices has no impact on this.  No device has any impact 
>on any other device's speed settings unless they are both connected to the 
>same physical cable and one of the devices is forcing a cable that *could* 
>be in LVD mode into SE mode instead.  Short of that, all device 
>negotiations are 100% independant of each other.
>

As I understood, that is what he said, he had everything connected to the
50pin...

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-pre10-jam3a, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.4mdk)
