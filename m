Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUCLPm6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUCLPm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:42:58 -0500
Received: from 217-162-71-11.dclient.hispeed.ch ([217.162.71.11]:41096 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S262208AbUCLPml
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:42:41 -0500
Message-ID: <4051DA6E.6070809@steudten.com>
Date: Fri, 12 Mar 2004 16:42:38 +0100
From: Thomas Steudten <alpha@steudten.com>
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: linux-admin@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Problems module autoload in 2.6.x
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: Mailer
X-Check: 2c1783c72b2809387bfafaa1e08e3128
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Kernel 2.6.4:
Some modules (floppy, lp, loop..) won´t be autoloaded any more since
2.4.21. There´s no block-major aso. request in the kernel-ring buffer.
I have /etc/modules.conf and /etc/modprobe.conf with modutils-2.4.21-23.1
and depmod -V: module-init-tools 3.0-pre5. How can I track this down?
Shouldn't be there a kmod process/ thread in the process list?

Sorry, if I miss something to read.


-- 
Tom

LINUX user since kernel 0.99.x 1994.
RPM Alpha packages at http://alpha.steudten.com/packages
Want to know what S.u.S.E 1995 cdrom-set contains?







