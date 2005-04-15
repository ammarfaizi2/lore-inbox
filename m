Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVDOAS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVDOAS7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 20:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVDOARl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 20:17:41 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:52355 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261677AbVDOAQ2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 20:16:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XIVzeq1rShxR7DlemsfSSJQB/ys3fw+as8cGpTnGdRqPem9uKrcFffAHBAiH9m3edWiSHxgSWwd5YhtktyI2gzXak7jJ+RzS5WetWyURooPgVLfyiAnt7EMHOjPY3ATliSyTFlZQDIkUnl+JgHV17eN/mEL8ENUAAphQxhzbgxg=
Message-ID: <c26b959205041417163acf174@mail.gmail.com>
Date: Fri, 15 Apr 2005 05:46:22 +0530
From: Imanpreet Arora <imanpreet@gmail.com>
Reply-To: Imanpreet Arora <imanpreet@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Question On TSS
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am a bit confused about the TSS. The documentation says that it
includes 3 fields SS0, SS1 and SS2 for privilige levels 0, 1, 2
respectively. And are set up when a task is first created, I can't
figure out why these fields are necessary. I think that these fileds
are necessary when we have moved from PL 3 to PL0 and these would
contain information about upper 3 stacks so that information can be
retrived.

-- 

Imanpreet Singh Arora
