Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271287AbTGWUIf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271276AbTGWUIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:08:35 -0400
Received: from postman1.arcor-online.net ([151.189.0.187]:26765 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S271287AbTGWUHh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:07:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: softpro@gmx.net
Reply-To: ahljoh@uni.de
To: linux-kernel@vger.kernel.org
Subject: Re: Re: directory inclusion in ext2/ext3
Date: Wed, 23 Jul 2003 22:22:24 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030723202225.F257B371@mendocino>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott McDermott <vaxerdec () frontiernet ! net> on 2003-07-23 20:04:26:

>> i have been looking for the possibility to display the
>> contents of several directories in another one, but have
>> so far not found anything suitable.

>This sounds like Al Viro's unionfs if I'm not mistaken.

well, not really. unionfs is close because with a "mount -o bind" and 
additive mounting my problem would be solved, but what i'm looking for is a 
very high-level solution. as i said, my idea of solving this is to have an 
inclusion directive in directory-files...

has nobody ever felt the lack of such functionality??

Johannes
