Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUEVWUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUEVWUP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 18:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUEVWUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 18:20:15 -0400
Received: from [62.29.68.203] ([62.29.68.203]:15232 "EHLO localhost")
	by vger.kernel.org with ESMTP id S261712AbUEVWUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 18:20:12 -0400
From: =?utf-8?q?=C4=B0smail_D=C3=B6nmez?= <kde@myrealbox.com>
Organization: Bogazici University
To: linux-kernel@vger.kernel.org
Subject: Vfat not working in 2.6.6 or 2.6.6-mm5
Date: Sun, 23 May 2004 01:21:05 +0300
User-Agent: KMail/1.6.52
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200405230121.05051.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

whenever I try to copy a file from mu usb flash disk ( which has fat32 fas on 
it ) . I got the following error in syslog :

May 23 01:13:23 localhost kernel: FAT: Filesystem panic (dev sda1)
May 23 01:13:23 localhost kernel:     fat_get_cluster: invalid cluster chain 
(i_pos 652)

Looks like fat support is broken or am I missing something?


Regards,
/ismail
