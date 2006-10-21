Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWJUX6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWJUX6M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 19:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWJUX6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 19:58:12 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:62935 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750810AbWJUX6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 19:58:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lNwTyZHytrtLHpemgdbG+p1fySbd5Sr2Gy7Ro96TCaMdp1Bz38IU75s3BaNSU54KvwWe1Wt1RQ0qDuKZVh8WWCbWTs91TV/odigE28uWnhJyyY8SbR3Y4Dbjx4iVc0FDbpMfFEb1xkNK3wksEgzuA9hbM3UauoAMUU3868phld4=
Message-ID: <ceccffee0610211657u66b758b7r78fbf1c75f5dea67@mail.gmail.com>
Date: Sun, 22 Oct 2006 01:57:36 +0200
From: "Linux Portal" <linportal@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: First benchmarks of the ext4 file system
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext4 is 20 percent faster writer than ext3 or reiser4, probably thanks
to extents and delayed allocation. On other tests it is either
slightly faster or slightly slower. reiser4 comes as a nice surprise,
winning few benchmarks. Both are very stable, no errors during
testing.

http://linux.inet.hr/first_benchmarks_of_the_ext4_file_system.html
