Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTG1LRR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 07:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTG1LRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 07:17:17 -0400
Received: from nic.bme.hu ([152.66.115.1]:59110 "EHLO nic.bme.hu")
	by vger.kernel.org with ESMTP id S262273AbTG1LRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 07:17:16 -0400
Message-ID: <3F25095B.6070607@namesys.com>
Date: Mon, 28 Jul 2003 15:30:35 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Egger <degger@fhm.edu>
Cc: Yury Umanets <umka@namesys.com>, Nikita Danilov <Nikita@Namesys.COM>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>,
       Alexander Lyamin <flx@namesys.com>
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
References: <3F1EF7DB.2010805@namesys.com>	 <1059062380.29238.260.camel@sonja>	 <16160.4704.102110.352311@laputa.namesys.com>	 <1059093594.29239.314.camel@sonja>	 <16161.10863.793737.229170@laputa.namesys.com>	 <1059142851.6962.18.camel@sonja>	 <1059143985.19594.3.camel@haron.namesys.com>	 <1059181687.10059.5.camel@sonja>	 <1059203990.21910.13.camel@haron.namesys.com>	 <1059228808.10692.7.camel@sonja>  <3F23D38B.3020309@namesys.com> <1059315015.10692.207.camel@sonja>
In-Reply-To: <1059315015.10692.207.camel@sonja>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger wrote:

>Are you sure CF cards have wear leveling? I'm pretty confident that they
>have defect sector management but no wear leveling. There's a huge
>difference between those two.
>
I am told that they do by flx.  After all, they are most used for the 
FAT filesystem.


-- 
Hans


