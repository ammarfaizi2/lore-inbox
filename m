Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVDDHml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVDDHml (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 03:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVDDHml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 03:42:41 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:41609 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261152AbVDDHmj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 03:42:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=BglCjFxq8pZLhQtvrT/yYFUQ4t1YG22840oQs4m9fIDFHEcoxuraz2xPsbe9Q1Qbku1GpzecdR9jH9MdlLcoxcLPXgy972q1uU/uxL+XDKEZR3P00Amo2+TqM+htSIZT0cyz7kZFR6v6aN2yy6XHwV4hRoski6/zMgpgyLEzro4=
Message-ID: <59ab6ac105040400423fefd96a@mail.gmail.com>
Date: Mon, 4 Apr 2005 09:42:39 +0200
From: =?ISO-8859-1?Q?Jose_=C1ngel_De_Bustos_P=E9rez?= 
	<jadebustos@gmail.com>
Reply-To: =?ISO-8859-1?Q?Jose_=C1ngel_De_Bustos_P=E9rez?= 
	  <jadebustos@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: A problem with kswapd
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a problem with kswapd and I didn't find anything in the
archives of the list (I hope not having missed someone).

kswapd is using 100% of CPU in a suse sles8 with kernel 2.4.241. This
machine has its FS under LVM and ResiserFS, except for /boot which is
in ext2.

Any idea? Thanks in advance.
-- 
____________________________________
Best wishes, José Angel de Bustos Pérez

jadebustos@linuxmail.org
jadebustos@gmail.com

Jabber ID jadebustos@jabber.org
ICQ ID 200368358
