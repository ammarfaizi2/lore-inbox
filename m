Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbULRLdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbULRLdt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 06:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbULRLdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 06:33:49 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:18207 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262212AbULRLdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 06:33:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=LxUV8nO6VlhWuiaWl9WZU7Y2/3l4J2sc8Ad/Jf6uLOCoh/BQsRJ2r2sCzbKM0t7ggdDleVqMimLRi01T9nLFHCfwFjOeJFcexm0FgyCrIrX78kD7sM8kTV6sTOhAEp1WxGQOFkFnAvXotRuSdyC06ch6Jic6h0FJgSxBkdWNAu4=
Message-ID: <2d7d2dd2041218033339ad23a1@mail.gmail.com>
Date: Sat, 18 Dec 2004 11:33:47 +0000
From: Simon Burke <simon.burke@gmail.com>
Reply-To: Simon Burke <simon.burke@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: BSD UFS2 support
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, im mainly a lurker but need to ask whether the newer freeBSD fs
(UFS2) is readable and writable.

I have googled a round to find that i can mount / as read only but no
more. Is it possible to mount my /usr partition within the BSD slice.
(ie i want to get ot /usr/home/$user/


-- 
Theres no place like ::1

Thanks,
SimonB
