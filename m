Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261499AbSJUSTY>; Mon, 21 Oct 2002 14:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbSJUSTY>; Mon, 21 Oct 2002 14:19:24 -0400
Received: from med-gwia-02a.med.umich.edu ([141.214.93.150]:58927 "EHLO
	mail-02.med.umich.edu") by vger.kernel.org with ESMTP
	id <S261499AbSJUSTX> convert rfc822-to-8bit; Mon, 21 Oct 2002 14:19:23 -0400
Message-Id: <sdb40e59.000@mail-02.med.umich.edu>
X-Mailer: Novell GroupWise Internet Agent 6.0.2
Date: Mon, 21 Oct 2002 14:25:13 -0400
From: "Nicholas Berry" <nikberry@med.umich.edu>
To: <devilkin-lkml@blindguardian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre10-ac2: i/o error on cdrom diskdump
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More clues please (h/w, error, command, etc.)

>>> DevilKin-LKML <devilkin-lkml@blindguardian.org> 10/21/02 02:20PM >>>
Hello All,

Whenever I try to dd a cdrom to an iso image I get an I/O error.  This problem 
has been present for some time, and I don't know if it's because I use 
ide-scsi or not (not been able to test).

Is this still an open issue, and is it likely to get fixed before 2.4.20 
final?

Thanks!

DK
-- 
New York's got the ways and means;
Just won't let you be.
		-- The Grateful Dead

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org 
More majordomo info at  http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at  http://www.tux.org/lkml/

