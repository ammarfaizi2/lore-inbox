Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVBVACI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVBVACI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 19:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVBVACI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 19:02:08 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:62162 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262182AbVBVAB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 19:01:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Z9e2U5eZgg3GyA5H4k7e8wpeGQdS/QAMoq9shauxJWoam1Pbh7vLLalZZmjFazfYnzq8e9CW82LnM3v2fKYQWxOoZrcsKM+JVVBAb9YPFn9fNUUUwDj5Ut6AM/sQIl7ujlvd4xA4Y8oUUNuX2m7ez7tHr3zguOinsqH7gM+wyIg=
Message-ID: <bbef41570502211601f5a47be@mail.gmail.com>
Date: Mon, 21 Feb 2005 19:01:54 -0500
From: Brandy Chin <brandy.chin@gmail.com>
Reply-To: Brandy Chin <brandy.chin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Disks Activity Stats
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I'm having some trouble in getting the number of disk blocks
read/written per second.  I found the link on /proc/diskstats but I
don't see that parameter somewhere.  If there's a way to get the
number, it'd be great.  Otherwise some cursory advice, pointer to more
links would be fine.

Thanks very much,

http://www.ibiblio.org/peanut/Kernel-2.6.10/iostats.txt
