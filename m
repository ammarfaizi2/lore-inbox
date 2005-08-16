Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965267AbVHPPZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965267AbVHPPZJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 11:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965268AbVHPPZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 11:25:09 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:28318
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S965267AbVHPPZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 11:25:07 -0400
Subject: HDAPS, Need to park the head for real
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Reply-To: abonilla@linuxwireless.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: hdaps devel <hdaps-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 09:25:14 -0600
Message-Id: <1124205914.4855.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	We are currently almost there with hdaps. We are thinking how we should
make things and have made most of the decesions. We still need help from
anyone that might know about this. Please, if you can think of anything,
let us know.

The head_park script given by Jens Axboe was good for us, but we need to
park the head of the hard drive for a certain amount of time, please
call it 5 seconds or 10 seconds. I/We do not know how to make this
script to *park* the head for the selected amount of time.

Can anyone give us a clue?

Here is the current head_park
http://hdaps.sourceforge.net/head_park

Cheers,

.Alejandro

