Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266850AbUHYLLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266850AbUHYLLb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 07:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUHYLLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 07:11:31 -0400
Received: from lucidpixels.com ([66.45.37.187]:40099 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S266850AbUHYLLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 07:11:10 -0400
Date: Wed, 25 Aug 2004 07:11:06 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Question regardig mount --bind option.
Message-ID: <Pine.LNX.4.61.0408250707590.20397@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any performance hit either with latency or bandwidth when using 
the detination path of a mount --bind option?

example:

# /ide/disk1
# mount --bind /ide/disk1 /home

Would /home be any slower than directly accessing /ide/disk1?

Thanks.


