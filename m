Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267160AbRGJWCG>; Tue, 10 Jul 2001 18:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267156AbRGJWB4>; Tue, 10 Jul 2001 18:01:56 -0400
Received: from imo-m05.mx.aol.com ([64.12.136.8]:48064 "EHLO
	imo-m05.mx.aol.com") by vger.kernel.org with ESMTP
	id <S267158AbRGJWBv>; Tue, 10 Jul 2001 18:01:51 -0400
Date: Tue, 10 Jul 2001 18:01:44 -0400
From: hunghochak@netscape.net (Ho Chak Hung)
To: linux-kernel@vger.kernel.org
Subject: __alloc_pages 4 order allocation failed
Mime-Version: 1.0
Message-ID: <2900C842.6FDFFA04.0F76C228@netscape.net>
X-Mailer: Franklin Webmailer 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I run a module, sometimes it gives such an error __alloc_pages 4 order allocation failed.
However, there is only 0 order page allocation function call within the whole module.
Does anyone know where does the 4 order allocation failure comes from?
Thanks

Steven
__________________________________________________________________
Get your own FREE, personal Netscape Webmail account today at http://webmail.netscape.com/
