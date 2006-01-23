Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWAWCdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWAWCdz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 21:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWAWCdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 21:33:54 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:58085 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751391AbWAWCdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 21:33:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=JL8Mn6znR+vZ/auRtHJtP+7CAR6IP+rKwN6K0lSFZp+gSIqRFXjCCxk6wktRyLuX+JJ9GH3qLc/fC0JTMSFRM6+0QqlbIRiN+Qaumz9H1E0LVCio2XUJbZ7MEDO+caIhGyONiSpS5dO9GCd+650YZSzAubOa0zw9nblYcQJdUls=
Message-ID: <43D4408B.8050004@gmail.com>
Date: Mon, 23 Jan 2006 11:33:47 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: [ANNOUNCE] quilt2git / git2quilt
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all.

I've made up two little perl scripts to convert back and forth between 
quilt patch series and git commit series.  Hope someone finds it useful.

http://home-tj.org/wiki/index.php/Misc

Thanks.

-- 
tejun
