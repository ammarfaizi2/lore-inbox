Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276096AbRJBSMk>; Tue, 2 Oct 2001 14:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276095AbRJBSMa>; Tue, 2 Oct 2001 14:12:30 -0400
Received: from mail.case.pt ([194.65.97.60]:9225 "EHLO case_primary.case.pt")
	by vger.kernel.org with ESMTP id <S276097AbRJBSMQ> convert rfc822-to-8bit;
	Tue, 2 Oct 2001 14:12:16 -0400
Message-ID: <01C14B74.FE666EE0.rui.ribeiro@case.pt>
From: Rui Ribeiro <rui.ribeiro@case.pt>
Reply-To: "rui.ribeiro@case.pt" <rui.ribeiro@case.pt>
To: "'Petr Titera'" <Petr.Titera@quick.cz>,
        "rui.ribeiro@case.pt" <rui.ribeiro@case.pt>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: linux kernel 2.4.10 possibly breaks LILO
Date: Tue, 2 Oct 2001 19:03:59 +0100
Organization: Case, S.A.
X-Mailer: Microsoft Internet E-mail/MAPI - 8.0.0.4211
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did have to upgrade LILO to a new version, when I *manually* upgrade from ext2 to Reiserfs. 

Rui

-----Original Message-----
From:	Petr Titera [SMTP:owl@volny.cz]
Sent:	Terça-feira, 2 de Outubro de 2001 19:11
To:	rui.ribeiro@case.pt
Cc:	linux-kernel@vger.kernel.org
Subject:	Re: linux kernel 2.4.10 possibly breaks LILO



> I'm using LILO 21.6.1 w/ 2.4.10 and Reiserfs in my two notebooks: a Compaq
Armada 1500c and a Compaq Armada
> 100S.

May be, that it is filesystem dependant (using ext3), but I dont know...
Looks like effect of blkdev-in-pagecache. I saw something similiar in past
when I played with loop-like devices.

Petr
>
> Rui


