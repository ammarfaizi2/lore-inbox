Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268079AbTBSJf0>; Wed, 19 Feb 2003 04:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268162AbTBSJf0>; Wed, 19 Feb 2003 04:35:26 -0500
Received: from host-212-9-163-139.dial.netic.de ([212.9.163.139]:29056 "EHLO
	solfire") by vger.kernel.org with ESMTP id <S268079AbTBSJfZ>;
	Wed, 19 Feb 2003 04:35:25 -0500
Date: Wed, 19 Feb 2003 09:59:05 +0100 (MET)
Message-Id: <20030219.095905.92587466.mccramer@s.netic.de>
To: wli@holomorphy.com
Cc: efraim@clues.de, linux-kernel@vger.kernel.org
From: Meino Christian Cramer <mccramer@s.netic.de>
In-Reply-To: <20030219073221.GR29983@holomorphy.com>
References: <20030219071932.GA3746@clues.de>
	<20030219073221.GR29983@holomorphy.com>
X-Mailer: Mew version 3.1 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Subject: Re: 2.5.62 fails to boot, Uncompressing... and then nothing
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.5.62 fails to boot, Uncompressing... and then nothing
Date: Tue, 18 Feb 2003 23:32:21 -0800
Message-ID: <20030219073221.GR29983@holomorphy.com>

Hi,

 I have the sam eproblem here, but ACPI is definetly not configured...
 Any idea else ?

 Thank you for any help in advance ! :O)


 Kind regards,
 Meino 

wli> On Wed, Feb 19, 2003 at 08:19:32AM +0100, Alexander Koch wrote:
wli> > I am experiencing problems getting certain 2.5.60 and
wli> > 2.5.61 and also 2.5.62 to boot. One 2.5.60 is working,
wli> > the others are just doing something as I only see the
wli> > Uncompressing... and then nothing is happening at all
wli> > except my hard disc doing something which is not booting,
wli> > I feel. I fail to remember what the difference was between
wli> > the two versions of 2.5.60 (one running, the other is not).
wli> > Any ideas/hints on what this is?
wli> 
wli> Do you have ACPI in your .config? Various ppl have been having
wli> issues resolved when ACPI's deconfigured lately. Breaking out an
wli> early printk patch of some flavor should probably help get some
wli> boot logs out so you can debug if you care to do so.
wli> 
wli> 
wli> -- wli
wli> -
wli> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
wli> the body of a message to majordomo@vger.kernel.org
wli> More majordomo info at  http://vger.kernel.org/majordomo-info.html
wli> Please read the FAQ at  http://www.tux.org/lkml/
wli> 
