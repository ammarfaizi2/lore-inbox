Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269387AbRHYOuB>; Sat, 25 Aug 2001 10:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269372AbRHYOtv>; Sat, 25 Aug 2001 10:49:51 -0400
Received: from [195.66.192.167] ([195.66.192.167]:42001 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S269387AbRHYOth>; Sat, 25 Aug 2001 10:49:37 -0400
Date: Sat, 25 Aug 2001 17:52:24 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <17711481589.20010825175224@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: smbmount problems
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed smbmount problems by carefully reinstalling kernel and samba.

The only thing left is this:
mount -t smbfs -o noexec //server/e /mnt
does not honor noexec! All files appear rwxr-xr-x.
-- 
Best regards,
VDA                          mailto:VDA@port.imtp.ilyichevsk.odessa.ua


