Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286298AbRLTRLM>; Thu, 20 Dec 2001 12:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286296AbRLTRLC>; Thu, 20 Dec 2001 12:11:02 -0500
Received: from ntmail.avint.net ([198.165.75.239]:47627 "EHLO NTMAIL.avint.net")
	by vger.kernel.org with ESMTP id <S286299AbRLTRKy>;
	Thu, 20 Dec 2001 12:10:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Brendan Pike <spike@superweb.ca>
Reply-To: spike@superweb.ca
Organization: Linux User
To: linux-kernel@vger.kernel.org
Subject: Re: IDE Harddrive Performance
Date: Thu, 20 Dec 2001 13:10:50 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01122013105001.27161@spikes>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here is -T

[root@spikes spike]# /sbin/hdparm -T /dev/hda 
/dev/hda:
Timing buffer-cache reads:   128 MB in  3.89 seconds = 32.90 MB/sec
