Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWBGByA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWBGByA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWBGByA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:54:00 -0500
Received: from s2.yuriev.com ([69.31.8.140]:34722 "HELO s2.yuriev.com")
	by vger.kernel.org with SMTP id S932186AbWBGBx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:53:59 -0500
Date: Mon, 6 Feb 2006 20:51:26 -0500
From: alex-lists-linux-kernel@yuriev.com
To: linux-kernel@vger.kernel.org
Subject: non-fakeraid controllers
Message-ID: <20060207015126.GA12236@s2.yuriev.com>
Reply-To: alex-lists-linux-kernel@yuriev.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	This is not an attempt to start a religious flamewar about what is
RAID vs. what is softraid vs. what is fakeraid. 

	Does anyone has a list/refence/etc on reasonably modern SCSI
controllers (at least u160) in a non-fakeraid way i.e. the way that would
allow linux to boot from a RAID protected disk array when one of the drives
in the array failed even if the root filesystem is located on the same
array?

Thanks,
Alex

