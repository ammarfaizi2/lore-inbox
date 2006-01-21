Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWAUJVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWAUJVL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 04:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWAUJVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 04:21:11 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:60200 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750706AbWAUJVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 04:21:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RABV0FmTVORsLd3So3xfSLaShXmQFOH/JZdn9XRCZDWdVlAKp/EzJveSR7uJL4Gl9MO5OO+hKgMFfETw5BgO6dXVqY1l1Ld+0Lj6nDXREbKVW3+kDoqlOGpGAs1+O7+FF5Nnv4BEj1QNnk/SaHCSMmp0oZ0sQX2JjG7kClRXHKA=
From: Chaitanya Chalasani <chaitanya.chalasani@gmail.com>
Organization: Gmail
To: linux-kernel@vger.kernel.org
Subject: Process ending up in "D" state
Date: Sat, 21 Jan 2006 14:55:09 +0530
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601211455.10075.chaitanya.chalasani@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have RHEL3 running on dell server 

The postmaster process ending up with D state and iowait going to 99%
while /var where the db files are present is only 60% full

-- 
Chaitanya Chalasani
