Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272588AbRHaCSz>; Thu, 30 Aug 2001 22:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272589AbRHaCSp>; Thu, 30 Aug 2001 22:18:45 -0400
Received: from sunfish.linuxis.net ([64.71.162.66]:54986 "HELO
	sunfish.linuxis.net") by vger.kernel.org with SMTP
	id <S272588AbRHaCSh>; Thu, 30 Aug 2001 22:18:37 -0400
From: "Adam McKenna" <adam-dated-999656018.ee55e0@flounder.net>
Date: Thu, 30 Aug 2001 19:13:38 -0700
To: linux-kernel@vger.kernel.org
Subject: Strange kernel messages
Message-ID: <20010830191338.D19430@flounder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
Mail-Copies-To: never
X-Delivery-Agent: TMDA v0.32/Python 2.1.1 (sunos5)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone please explain what these error messages mean?

Aug 30 12:23:17 ren kernel: expected (0x3af6c03f/0x24d6e80), got
(0x3af6c03f/0x24d4ba0)
Aug 30 12:23:17 ren kernel: expected (0x3af6c03f/0x24d4ba0), got
(0x3af6c03f/0x24d6e80)
Aug 30 12:35:02 ren kernel: expected (0x3af6c03f/0x24d6e80), got
(0x3af6c03f/0x24d4ba0)
Aug 30 12:35:02 ren kernel: expected (0x3af6c03f/0x24d4ba0), got
(0x3af6c03f/0x24d6e80)
Aug 30 13:49:36 ren kernel: expected (0x3af6c03f/0x2c05e81), got
(0x3af6c03f/0x2c05ea0)
Aug 30 13:49:36 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
(0x3af6c03f/0x2c05e81)
Aug 30 13:54:38 ren kernel: expected (0x3af6c03f/0x2c05e81), got
(0x3af6c03f/0x2c05ea0)
Aug 30 13:54:38 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
(0x3af6c03f/0x2c05e81)
Aug 30 13:59:40 ren kernel: expected (0x3af6c03f/0x2c05e81), got
(0x3af6c03f/0x2c05ea0)
Aug 30 13:59:40 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
(0x3af6c03f/0x2c05e81)
Aug 30 14:04:41 ren kernel: expected (0x3af6c03f/0x2c05e81), got
(0x3af6c03f/0x2c05ea0)
Aug 30 14:04:41 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
(0x3af6c03f/0x2c05e81)
Aug 30 14:09:43 ren kernel: expected (0x3af6c03f/0x2c05e81), got
(0x3af6c03f/0x2c05ea0)
Aug 30 14:09:43 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
(0x3af6c03f/0x2c05e81)
Aug 30 14:10:19 ren kernel: expected (0x3af6c03f/0x2c05e81), got
(0x3af6c03f/0x2c05ea0)
Aug 30 14:10:19 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
(0x3af6c03f/0x2c05e81)
Aug 30 14:15:17 ren kernel: expected (0x3af6c03f/0x2c05e81), got
(0x3af6c03f/0x2c05ea0)
Aug 30 14:15:17 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
(0x3af6c03f/0x2c05e81)
Aug 30 14:20:19 ren kernel: expected (0x3af6c03f/0x2c05e81), got
(0x3af6c03f/0x2c05ea0)
Aug 30 14:20:19 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
(0x3af6c03f/0x2c05e81)
Aug 30 14:25:21 ren kernel: expected (0x3af6c03f/0x2c05e81), got
(0x3af6c03f/0x2c05ea0)
Aug 30 14:25:21 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
(0x3af6c03f/0x2c05e81)
Aug 30 14:30:23 ren kernel: expected (0x3af6c03f/0x2c05e81), got
(0x3af6c03f/0x2c05ea0)
Aug 30 14:30:23 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
(0x3af6c03f/0x2c05e81)
Aug 30 14:35:27 ren kernel: expected (0x3af6c03f/0x2c05e81), got
(0x3af6c03f/0x2c05ea0)
Aug 30 14:35:27 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
(0x3af6c03f/0x2c05e81)

This is on stock Linux 2.4.5, SMP enabled.

Thanks,

--Adam
