Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264076AbTKSTy5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 14:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbTKSTy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 14:54:57 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:61860 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S264076AbTKSTy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 14:54:57 -0500
Subject: instructions of 2.6 README not working
From: Ludootje <ludootje@linux.be>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1069271692.17900.4.camel@libranet>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 19 Nov 2003 20:54:52 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I just download 2.6-test9 and line 122 of the README says "sudo make O=/home/name/build/kernel install_modules install".
This doesn't work though (at least not here). I tried this:
$ su
# make O=/mnt2/var/kernels/linux-2.6.0-test9/build modules
# make O=/mnt2/var/kernels/linux-2.6.0-test9/build modules_install
and it worked. I suppose this is a mistake in the README... no?

Ludootje

(Please Cc me if you reply as I'm not subscribed)

