Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWHTE5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWHTE5u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 00:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWHTE5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 00:57:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:18768 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750759AbWHTE5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 00:57:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=o9o41YbfziWLLc5UDC6rJ52JcJW3YRlePGcUHwTWYI0qcf83uwuJbb2e2dkv4fM8GAjHXfkKvxyzMtVjLqUsxN1s2jJnJXs5vCTrJiQI1Zh+KaxX4K3o20VeEUYAOIPdDfjjidT1icR2ZmU9jHuFP9FAGzWSyRkbU/Cv2LbFg9Y=
Message-ID: <44E7EBCB.9000206@gmail.com>
Date: Sun, 20 Aug 2006 00:57:47 -0400
From: Ryan Newberry <brnewber@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060731)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: efault@gmx.de, mingo@elte.hu
Subject: Slow CD audio ripping speeds after 2.6.17 kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Basically the issue and my observations can be summed up here: 
http://bugzilla.kernel.org/show_bug.cgi?id=7027
, and I'm just following orders :-)


-- 
Ryan Newberry
http://ripoffc.sourceforge.net
"All mankind is divided into three classes: those that are immovable, those that are movable, and those that move." - Benjamin Franklin

