Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269557AbTHJOSX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 10:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269619AbTHJOSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 10:18:22 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:26894 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S269557AbTHJOSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 10:18:21 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: removing module by path name?
Date: Sun, 10 Aug 2003 18:11:50 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308101811.50581.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it intentional?

{pts/2}% sudo rmmod arch/i386/kernel/msr.ko
{pts/2}% grep msr /proc/modules
{pts/2}%

-andrey

