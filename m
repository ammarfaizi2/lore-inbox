Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291110AbSBGFPn>; Thu, 7 Feb 2002 00:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291122AbSBGFPW>; Thu, 7 Feb 2002 00:15:22 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:38138 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S291110AbSBGFPR>; Thu, 7 Feb 2002 00:15:17 -0500
Date: Thu, 7 Feb 2002 06:15:02 +0100
From: Harald Dunkel <harri@synopsys.COM>
Message-Id: <200202070515.g175F2DC002321@bilbo.gr05.synopsys.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17: kmod fails, but modprobe is OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Since yesterday (when I run the last Debian upgrade) kmod fails to
load some modules, e.g. 3c59x or hisax. Modprobe on the command line
works as expected. Downgrading modutils to the previous version did
not help.

Anybod got an idea whats going on here?


Thanx

Harri
