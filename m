Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTK0LI7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 06:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264480AbTK0LI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 06:08:59 -0500
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:48325 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S264479AbTK0LI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 06:08:58 -0500
Message-ID: <3FC5DB47.9040205@tu-harburg.de>
Date: Thu, 27 Nov 2003 12:08:55 +0100
From: Robert Schaft <robert.schaft@tu-harburg.de>
Organization: TUHH
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.4) Gecko/20030730
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: wrong line in README
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I stricly followed the README compililing the
kernel 2.6-test10 and failed.

line 119 in linux/README should not be
     sudo make O=/home/name/build/kernel install_modules install
but
     sudo make O=/home/name/build/kernel modules_install install

greetings
	Robert Schaft

