Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129446AbRCMJW7>; Tue, 13 Mar 2001 04:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129657AbRCMJWt>; Tue, 13 Mar 2001 04:22:49 -0500
Received: from mail22.bigmailbox.com ([209.132.220.199]:63505 "EHLO
	mail22.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S129446AbRCMJWe>; Tue, 13 Mar 2001 04:22:34 -0500
Date: Tue, 13 Mar 2001 01:21:13 -0800
Message-Id: <200103130921.BAA01799@mail22.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [24.5.157.48]
From: "Quim K Holland" <qkholland@my-deja.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: About DC-315U scsi driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "AC" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> Indeed; people report more problems on 2.4 kernels than on
>> 2.2 kernels. I currently have no clue why.

AC> 2.4 causes longer continuous I/O requests to be sent to the
AC> drive for one

Sorry but I am having a hard time understanding this comment.
Are you saying 2.4 causes applications to send I/O requests
longer than the hardware accepts, and if applications are
properly written they should be able to limit the continuous
requests from the userland (which means it is an application
bug)?  Or are you saying 2.4 kernel should not ``cause longer
continuous I/O requests to be sent'' but it ends up doing
so (which means its a kernel bug)?


------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/


