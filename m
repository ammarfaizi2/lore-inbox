Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267327AbTACAAO>; Thu, 2 Jan 2003 19:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbTACAAO>; Thu, 2 Jan 2003 19:00:14 -0500
Received: from main.gmane.org ([80.91.224.249]:56457 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S267327AbTACAAN>;
	Thu, 2 Jan 2003 19:00:13 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Steven Barnhart" <sbarn03@softhome.net>
Subject: [2.5.54] OOPS: unable to handle kernel paging request
Date: Thu, 02 Jan 2003 19:08:55 -0500
Message-ID: <pan.2003.01.03.00.08.53.924016@softhome.net>
References: <20030102171803.GQ6114@fs.tum.de> <Pine.LNX.4.33.0301021827160.649-100000@pnote.perex-int.cz> <20030102132640.GA328@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.13.0 (The whole remains beautiful)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I seem to get a very nasty oops exactly when booting 2.5.54. When i
boot to the kernel I immediately get a kksymoops report flooding my
screen. This happens to fast that the text blurs and basically everything
stays where its at. There is no way to stop it except rebooting. I do not
have any serial connections to send the output to so I got (hopefully) the
most important line. The oops says "unable to handle kernel paging
request at virtual address ffffff8d (there may be another 'f' in there). I
searched through the archives and their seems to be a few oops reports of
the same kind but no patches and the only kernel was 2.5.48-bk I think.
Any thoughts?


