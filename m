Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266792AbTATThj>; Mon, 20 Jan 2003 14:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbTATThj>; Mon, 20 Jan 2003 14:37:39 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:34312 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S266792AbTATThh>; Mon, 20 Jan 2003 14:37:37 -0500
X-Envelope-From: roubm9am@barbora.ms.mff.cuni.cz
Message-ID: <190d01c2c0bc$9b6c35e0$551b71c3@krlis>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: <lkml@scienceworks.com>
Cc: <linux-kernel@vger.kernel.org>
References: <20030120183442.GA3440@poseidon.wasserstadt.de>
Subject: Re: Promise PDC20268 FastTrack 100 TX2 (PDC20268)
Date: Mon, 20 Jan 2003 20:46:10 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-Mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make a single drive strip array - promise will see array defined and the
reboot will pass correctly.
Then you can use sw raid.
    Milan Roubal
    roubm9am@barbora.ms.mff.cuni.cz

----- Original Message -----
From: <lkml@scienceworks.com>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, January 20, 2003 7:34 PM
Subject: Promise PDC20268 FastTrack 100 TX2 (PDC20268)


> Hello all,
>
> I have a Promise FastTrack 100 TX2 (PDC20268) IDE-controller
> (BIOS v2.00.0.24) used in a linux MD-RAID.  Aside from various
> other annoying Promise-problems, I am not able to perform a
> remote boot because the brain-dead Promise-BIOS "complains" that
> no array is defined, and requires one to press ESC to continue
> booting.  I would very much appreciate any tips as to how I can
> circumvent this "feature".
>
> Best regards,
>
> Robert
>
> PS. Please CC me, as I am not in the list.


