Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWGDP0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWGDP0s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWGDP0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:26:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:48658 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751190AbWGDP0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:26:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=dKFQf89O4vvPVtUJg2VS2LXMW8raPkWTV86IXRtsh4w9CU+K6zZb+gJaUXX3mgniHwKP8A1HgIOWwOs1Oc0k5MolFfYMBFXOIkFobiRB2DNGGpuac1eeNFRD2Pe0bbomvfuw6ETOgYupp5A1WpCjefJBpsDyYMVOIJ9ZL6MZywA=
Message-ID: <44AA89D2.8010307@innova-card.com>
Date: Tue, 04 Jul 2006 17:31:30 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Franck <vagabon.xyz@gmail.com>
Subject: [PATCH 0/7] Clean up the bootmem allocator (try #2)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Here is a set of patches that clean up the bootmem allocator. These
patches don't add/remove any features. They only make the code more
readable.

I don't get a lot of feedbacks during my first attempt except from
Dave Hansen where I tried to answer them.

It boots fine on my machine.

Thanks,

		Franck
