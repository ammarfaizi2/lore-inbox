Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUHJNXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUHJNXX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUHJNUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:20:11 -0400
Received: from AGrenoble-152-1-15-201.w82-122.abo.wanadoo.fr ([82.122.13.201]:50320
	"EHLO awak.dyndns.org") by vger.kernel.org with ESMTP
	id S265263AbUHJNNo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:13:44 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Xavier Bestel <xavier.bestel@free.fr>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mj@ucw.cz, James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk,
       axboe@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <200408101246.i7ACkTbm014030@burner.fokus.fraunhofer.de>
References: <200408101246.i7ACkTbm014030@burner.fokus.fraunhofer.de>
Content-Type: text/plain; charset=utf-8
Message-Id: <1092143397.8744.19.camel@gonzales>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 10 Aug 2004 15:09:57 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 10/08/2004 à 14:46, Joerg Schilling a écrit :

> Your statements are correct for programs that include locale support.

If your program doesn't have locale support, then it shouldn't print
locale-dependant text, that's all. Saying it's someone else's fault for
not using the same locale as you is misplaced at best.



