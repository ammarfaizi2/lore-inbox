Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267765AbTBQPKb>; Mon, 17 Feb 2003 10:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267767AbTBQPKb>; Mon, 17 Feb 2003 10:10:31 -0500
Received: from zork.zork.net ([66.92.188.166]:59788 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S267765AbTBQPKa>;
	Mon, 17 Feb 2003 10:10:30 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Performance of ext3 on large systems
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: IMPROPER FORETHOUGHT, ULTERIOR
 MOTIVES
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Mon, 17 Feb 2003 15:20:27 +0000
In-Reply-To: <20030216172942.06b0ddba.akpm@digeo.com> (Andrew Morton's
 message of "Sun, 16 Feb 2003 17:29:42 -0800")
Message-ID: <6uisvj9bno.fsf@zork.zork.net>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2
 (i386-debian-linux-gnu)
References: <66390000.1045442686@[10.10.2.4]>
	<20030216172942.06b0ddba.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Andrew Morton quotation:

> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>>
>> (look at system time ... eeek!)
>
> Can we just say that ext3's talents lie elsewhere?
>
> I've got some stuff which helps a bit, but nobody has had the time
> to implement the significant overhaul which is needed here.
>
> noatime would help.

ext3 doesn't implement noatime!?  Hurg...

-- 
 /                          |
[|] Sean Neakums            | Size *does* matter.
[|] <sneakums@zork.net>     | That's why I use Emacs.
 \                          |
