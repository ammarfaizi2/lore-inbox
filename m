Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276092AbRJBSLA>; Tue, 2 Oct 2001 14:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276089AbRJBSKu>; Tue, 2 Oct 2001 14:10:50 -0400
Received: from smtp1.vol.cz ([195.250.128.43]:18963 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S276087AbRJBSKg>;
	Tue, 2 Oct 2001 14:10:36 -0400
Message-ID: <003a01c14b6d$96e36d10$13a76cc0@NEVSKIJ>
Reply-To: "Petr Titera" <Petr.Titera@quick.cz>
From: "Petr Titera" <owl@volny.cz>
To: <rui.ribeiro@case.pt>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <01C14B73.9F052000.rui.ribeiro@case.pt>
Subject: Re: linux kernel 2.4.10 possibly breaks LILO
Date: Tue, 2 Oct 2001 20:10:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> I'm using LILO 21.6.1 w/ 2.4.10 and Reiserfs in my two notebooks: a Compaq
Armada 1500c and a Compaq Armada
> 100S.

May be, that it is filesystem dependant (using ext3), but I dont know...
Looks like effect of blkdev-in-pagecache. I saw something similiar in past
when I played with loop-like devices.

Petr
>
> Rui



