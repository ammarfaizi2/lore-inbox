Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132685AbRDCHYo>; Tue, 3 Apr 2001 03:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132686AbRDCHYf>; Tue, 3 Apr 2001 03:24:35 -0400
Received: from isunix.it.ilstu.edu ([138.87.124.103]:59140 "EHLO
	isunix.it.ilstu.edu") by vger.kernel.org with ESMTP
	id <S132685AbRDCHYW>; Tue, 3 Apr 2001 03:24:22 -0400
From: Tim Hockin <thockin@isunix.it.ilstu.edu>
Message-Id: <200104030731.CAA07050@isunix.it.ilstu.edu>
Subject: 66MHz PCI
To: linux-kernel@vger.kernel.org
Date: Tue, 3 Apr 2001 02:31:40 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

is it possible to detect whether a device is running at 66MHz (as opposed
to 33)?  PCI defines a 66MHz capable bit, but not a 66MHz enabled bit.  We
have a silly device that seems to need to know what it's bus speed is, but
have no way to tell from software (that I know of).

So, pray tell -- is there a way to figure it out?
