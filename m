Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278813AbRJaBMk>; Tue, 30 Oct 2001 20:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278815AbRJaBMc>; Tue, 30 Oct 2001 20:12:32 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:26416 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S278813AbRJaBML> convert rfc822-to-8bit; Tue, 30 Oct 2001 20:12:11 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Mark Atwood <mra@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Identify IDE device?
Date: Wed, 31 Oct 2001 02:11:48 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <m3pu74k4v5.fsf@khem.blackfedora.com>
In-Reply-To: <m3pu74k4v5.fsf@khem.blackfedora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <E15yjvw-0003CO-00@mrvdom01.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 31. Oktober 2001 01:52 schrieb Mark Atwood:
> Is there a way, via an ioctl call, or something to identify what
> specific IDE hard disk or other IDE device is hooked up to the IDE
> controller?

What about 

cat /proc/ide/hda/model 


greetings

Christian Bornträger
