Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWG3SXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWG3SXu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWG3SXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:23:50 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:58345 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932401AbWG3SXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:23:50 -0400
Date: Sun, 30 Jul 2006 20:22:18 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hans Reiser <reiser@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: 2.6.18-rc3 - ReiserFS - warning: vs-8115: get_num_ver: not
 directory or indirect item
In-Reply-To: <9a8748490607300608v65ce3bdcsbb47273bb82a2d6c@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0607302019020.25626@yvahk01.tjqt.qr>
References: <9a8748490607300608v65ce3bdcsbb47273bb82a2d6c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I just got a warning message with 2.6.18-rc3 that I've never seen before :

Interesting. I have seen this by chance on a plain Debian 3.1r2 (which I 
already have deleted again in the meantime, because it was just that: a 
test vm).

> ReiserFS: sda4: warning: vs-8115: get_num_ver: not directory or indirect item


Jan Engelhardt
-- 
