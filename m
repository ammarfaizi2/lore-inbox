Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132553AbRD1IBq>; Sat, 28 Apr 2001 04:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132563AbRD1IBg>; Sat, 28 Apr 2001 04:01:36 -0400
Received: from smtp.axime.com ([160.92.122.233]:60613 "HELO smtp.axime.com")
	by vger.kernel.org with SMTP id <S132553AbRD1IBa>;
	Sat, 28 Apr 2001 04:01:30 -0400
Message-ID: <3AEA86DF.696CD1A7@atosorigin.com>
Date: Sat, 28 Apr 2001 11:01:19 +0200
From: valery <valery.brasseur@atosorigin.com>
Organization: ATOS multimedia
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: linux and high volume web sites
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a high volume web site under linux :
kernel is 2.2.17
hardware is 5 bi-PIII 700Mhz / 512Mb, eepro100
all server are diskless (nfs on an netapp filer) except for tmp and swap

dispatch is done by the Resonate product

web server is apache+php (something like 400 processes), database
backend is a mysql on the same hardware


in high volume from time to time machines are "freezing" then after a
few seconds they "reappear" and response timne is 


how can I investigate all these problems ?
