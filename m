Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316654AbSE1OeA>; Tue, 28 May 2002 10:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316657AbSE1Od7>; Tue, 28 May 2002 10:33:59 -0400
Received: from ns.ithnet.com ([217.64.64.10]:781 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S316654AbSE1Od6>;
	Tue, 28 May 2002 10:33:58 -0400
Date: Tue, 28 May 2002 16:33:58 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: file locks in 2.4.18
Message-Id: <20020528163358.51e33760.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

what is the preferred way to increase the maximum number of locks per file in
2.4.18 (and above :-)? Is this fs-type-dependant? My concern is reiserfs 3.6. I
found out the hard way that there is a max of around 128 currently...

Regards,
Stephan
