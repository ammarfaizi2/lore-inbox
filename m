Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262728AbSJ3BZr>; Tue, 29 Oct 2002 20:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262810AbSJ3BZq>; Tue, 29 Oct 2002 20:25:46 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:54545 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262728AbSJ3BZq>; Tue, 29 Oct 2002 20:25:46 -0500
Date: Tue, 29 Oct 2002 14:42:14 -0600
From: Courtney Grimland <cgrimland@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: agp_try_unsupported=1
Message-Id: <20021029144214.13a83df0.cgrimland@yahoo.com>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Real Men Don't Use Distros - www.linuxfromscratch.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stock 2.4.19
VIA KT400 Northbridge
VIA VT8235 Southbridge
Radeon 7500

Why does this only work as an argument to modprobe with via82cxxx built
as a module, but not as a parameter to lilo with the same driver built
in to the kernel?
