Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313917AbSDPVU0>; Tue, 16 Apr 2002 17:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313918AbSDPVUZ>; Tue, 16 Apr 2002 17:20:25 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:45931 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S313917AbSDPVUZ> convert rfc822-to-8bit; Tue, 16 Apr 2002 17:20:25 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: smbfs 2.4.19pre6
Date: Tue, 16 Apr 2002 23:20:22 +0200
X-Mailer: KMail [version 1.4]
In-Reply-To: <200204162310.09755.linux-kernel@borntraeger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200204162320.22504.linux-kernel@borntraeger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Bornträger wrote:

> Every process accessing the mount point falls into uniterruptable sleep -
> till the reboot. Even a lsof is frozen.

I have to correct myself. After some minutes the frozen processes stop.

Sorry.



