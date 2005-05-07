Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbVEGWQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbVEGWQQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 18:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVEGWQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 18:16:16 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:39309 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262754AbVEGWQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 18:16:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=OsIWWMpkGkHM96xFrlttbMMH70vV/Ur6kwxDbfUVqqY6EDtQLCplN867qq4ljcAUgUVdNO5rPYCa1t1VkW05dMKvzY0xZi0YbdDo0CckCMWBL0i8eFh5M54EM8sxZqWwMPkEtv2xjETjofxJvjDoOqvO8zGbdP1eCl9X9gFV6qI=
Message-ID: <427D3E2D.1010503@gmail.com>
Date: Sat, 07 May 2005 18:16:13 -0400
From: Keenan Pepper <keenanpepper@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Pause for debugging?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way to make the entire kernel pause for a few seconds for 
debugging purposes? I looked at kdb and kgdb but neither of those works 
on powerpc, and I don't need all that functionality anyway, I just want 
it to pause for a few seconds and then resume.

Keenan Pepper
