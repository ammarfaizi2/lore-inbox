Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135788AbREFRmc>; Sun, 6 May 2001 13:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135792AbREFRmW>; Sun, 6 May 2001 13:42:22 -0400
Received: from fe8.southeast.rr.com ([24.93.67.55]:55047 "EHLO
	mail8.carolina.rr.com") by vger.kernel.org with ESMTP
	id <S135788AbREFRmN>; Sun, 6 May 2001 13:42:13 -0400
From: Zilvinas Valinskas <zvalinskas@carolina.rr.com>
Date: Sun, 6 May 2001 13:41:40 -0400
To: Jussi Laako <jlaako@pp.htv.fi>
Cc: Seth Goldberg <bergsoft@home.com>, linux-kernel@vger.kernel.org
Subject: Re: Athlon possible fixes
Message-ID: <20010506134140.A905@clt88-175-140.carolina.rr.com>
In-Reply-To: <200105051626.SAA16651@cave.bitwizard.nl> <3AF4824F.8964E53B@home.com> <3AF57F63.9900089E@pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3AF57F63.9900089E@pp.htv.fi>; from jlaako@pp.htv.fi on Sun, May 06, 2001 at 07:44:19PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2001 at 07:44:19PM +0300, Jussi Laako wrote:
> Seth Goldberg wrote:
> > 
> > and rebooted, the system stayed up a lot longer, but it still crashed (I
> > was in Xwindows and the crash was partially written to the log file)
> > after around 3 minutes of work in X.
> 
> Hmm, I'm wondering if this could be same bug that I'm seeing with ASUS
> A7V133 & Duron/800 when using IDE autotuning (PDC20265).
> 
> Still haven't got any replies suggesting any reason for lockups I'm seeing
> (no oopses). Or is the Promise driver just buggy, because system is solid
> with noautotune. RAID5 (md) on that server is just little bit sluggish with
> ~1.7 MB/s transfer rate... I should have stayed with SCSI disks...

http://www.viahardware.com/

there you should find (if I'm right) somewhere mentioned that you likely
to trash your hard drives or experience random lock ups with KT133a chipset
especially if you use off-board ide controller ... As to why it happens is
beyond me to explain ...

(maybe even this doesn't apply for case).
-- 
Zilvinas Valinskas
