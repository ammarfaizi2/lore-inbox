Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbTJTVe0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 17:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbTJTVe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 17:34:26 -0400
Received: from fluorine.one-2-one.net ([217.115.142.97]:46094 "EHLO
	fluorine.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S262819AbTJTVeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 17:34:24 -0400
Message-ID: <002c01c39750$12c20970$fb457dc0@tgasterix>
From: "Thomas Giese" <thomas.giese@tgsoftware.de>
To: <linux-kernel@vger.kernel.org>
Subject: modprobe.conf 
Date: Mon, 20 Oct 2003 23:21:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

i generated modprobe.conf as described. 

when starting x, the intel-agp will not be loaded.
the same with old kernel (2.4.X) and old modutils worked fine.

is here someone, who knows, what i have to change in my modprobe.conf?
i didn't found any samples in the net.
when i start modprobe intel-agp manually, then x runs.

http://www.tgsoftware.de/modprobe.conf

thanks

thomas
