Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316216AbSEQNmQ>; Fri, 17 May 2002 09:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316217AbSEQNmP>; Fri, 17 May 2002 09:42:15 -0400
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:6470 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S316216AbSEQNmP>; Fri, 17 May 2002 09:42:15 -0400
Date: Fri, 17 May 2002 15:40:33 +0200 (CEST)
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: Ed Vance <EdV@macrolink.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: OX16PCI954 - more than 921600/3000000
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A7825@EXCHANGE>
Message-ID: <Pine.LNX.4.44.0205171536260.3934-100000@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002, Ed Vance wrote:

> Notice that there are no choices that are even close. The 954 UART can do
> much better than this with its CPR prescaler register, but this
> functionality is not supported by the current driver.  However, a patch to
> properly support the CPR register has been posted to the list a few times.
> An archived message that contains the patch and caveats is found here:
> (Thanks Fabrizio)
> 
> http://groups.google.com/groups?dq=&hl=en&group=mlist.linux.serial&safe=off&
> selm=linux.serial.OFAB55B09E.868BB835-ONC1256B82.005C3839%40diamond.philips.
> com

Thank You very much for this link and for some suggestions. I will try
this patch next week.

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

