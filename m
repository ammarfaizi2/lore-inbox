Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264979AbSJPJEP>; Wed, 16 Oct 2002 05:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264981AbSJPJEP>; Wed, 16 Oct 2002 05:04:15 -0400
Received: from web21204.mail.yahoo.com ([216.136.131.77]:10061 "HELO
	web21204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264979AbSJPJEO>; Wed, 16 Oct 2002 05:04:14 -0400
Message-ID: <20021016091011.9346.qmail@web21204.mail.yahoo.com>
Date: Wed, 16 Oct 2002 02:10:11 -0700 (PDT)
From: Melkor Ainur <melkorainur@yahoo.com>
Subject: user space virtual address to a vm_area_struct
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there a recommended way for a driver to take an
application provided virtual address while executing
in the syscall context of that same application and
find the corresponding vm_area_struct (if exists for
that address) that spans that virtual address?

Melkor

__________________________________________________
Do you Yahoo!?
Faith Hill - Exclusive Performances, Videos & More
http://faith.yahoo.com
