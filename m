Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVCKHXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVCKHXi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 02:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbVCKHXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 02:23:37 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:59038 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262585AbVCKHXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 02:23:35 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: netdev@oss.sgi.com
Subject: Last night Linus bk - netfilter busted?
Date: Fri, 11 Mar 2005 02:23:34 -0500
User-Agent: KMail/1.7.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503110223.34461.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My box gets stuck while booting (actually starting ntpd) whith tonight
pull from Linus. It looks like it is spinning in ipt_do_table when I do
SysRq-P. No call trace though.

Anyone else seeing it? Any ideas?

-- 
Dmitry
