Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbTHWNgA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 09:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbTHWNf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 09:35:59 -0400
Received: from [193.10.185.236] ([193.10.185.236]:45072 "HELO
	smtp.dormnet.his.se") by vger.kernel.org with SMTP id S263609AbTHWNf6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 09:35:58 -0400
Date: Sat, 23 Aug 2003 15:35:41 +0200
From: Patrick =?ISO-8859-1?Q?B=F6rjesson?= <psycho@rift.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Problem with memstick for Sony DSC-P9
Message-Id: <20030823153541.652e1f3f.psycho@rift.ath.cx>
Organization: HiS
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a Sony DSC-P9 digital camera and when trying to use Sony's own
memstick I can't mount it over USB. When using a Lexar memstick there's
no problem at all. The error-message I get from mount when trying to
mount the Sony stick is:
mount: you must specify the filesystem type
And when specifying vfat that the Lexar memstick uses I get a wrong
fs-type error instead.
Anyone know which filesystem I should use or is it a lost cause getting
the Sony memstick working?

Patrick Börjesson

-- 
Public key id: 4C5AB0BF
Public key available at search.keyserver.net[:11371]
