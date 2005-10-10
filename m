Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVJJOHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVJJOHK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbVJJOHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:07:10 -0400
Received: from qproxy.gmail.com ([72.14.204.196]:40502 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750797AbVJJOHJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:07:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QO0sIdf5naf6AatxpFaQeDVjaKw2QlGgUkMZIqZPw4hcdB0pfZeOdjrsC/q9nalvtBB7Bxqxs3SqTT4D4Ekhiwlit/5Ag+5+4rnDS9M5dAAq5+tmpzDGa94DtmqVCs77DeAj8D59K3YvGQBBKIO+K51bYkZMzW7Qm/0NVwWBmNo=
Message-ID: <b9a245c10510100707l1838dd70i459508acf69dfde5@mail.gmail.com>
Date: Mon, 10 Oct 2005 19:37:07 +0530
From: Vivek Kutal <vivek.kutal@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ZONE_HIGHMEM query
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyone ,
All books that I have read say that the concept of ZONE_HIGHMEM is
introduced because some architectures cannot directly map memory
beyond 896MB (x86).

My question is What is direct mapping(does it mean, same virtual
address and physical address) and why cant a architecture directly map
a particular region in the memory?



--
Thanks and Regards
Vivek Kutal
http://vivekkutal.blogspot.com

           "Live as if you were to die tomorrow. Learn as if you were
to live forever."
