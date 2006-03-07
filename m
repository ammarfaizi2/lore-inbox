Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWCGRUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWCGRUA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWCGRT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:19:59 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:41196 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751320AbWCGRT7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:19:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UPAyXIizDmHXzWxgMh568/OeQ8StbDdROssBTXFbqdVN7AvyxSV/vl53hQgFXxWfb0tduE7tJdf1pcvYTRyTv4MCzUXAIIAB0sGj3epB/iP9UHd+6M/vimXzrIhjT8VBbTZk8ea784rf5HeWDXYUpDQVEWEUo7Y00u0xWXHuGms=
Message-ID: <6bffcb0e0603070919k64e325f6h@mail.gmail.com>
Date: Tue, 7 Mar 2006 18:19:58 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: 2.6.15-rt20 compilation errors
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have noticed that -rt19 and -rt20 doesn't compile on my system.

Here is config http://www.stardust.webpages.pl/files/rt/2.6.15-rt20/rt-config
Here is build log
http://www.stardust.webpages.pl/files/rt/2.6.15-rt20/rt-buildlog

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
