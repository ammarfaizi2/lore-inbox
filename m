Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVCQAy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVCQAy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbVCQAyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:54:24 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:1037 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261873AbVCQArU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 19:47:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=qFlSmj3Zc0hSfbl61CVcgtaWtO0aEeVrK9Cu/KNkWFp3MUV4W9P6qB8KLCRQkQRQTFzB/kIiPygwDSqf+D/2lRfmLDMvmQ/ydzZbY3DLEpIsZJEPC4hfBNKM7JfVnDDW76Ccq39OsvmJPpzdngN0ELNjLpzAW/P7F6cdKiDnZ8I=
Message-ID: <a44ae5cd05031616477698e331@mail.gmail.com>
Date: Wed, 16 Mar 2005 16:47:19 -0800
From: Miles Lane <miles.lane@gmail.com>
Reply-To: Miles Lane <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Support for the SiSM741 chipset?
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am considering buying an Averatec AV6210X60, which uses this chipset.

A description of the chipset is here:
http://www.linuxelectrons.com/article.php/20031216092226919

The marketing blurb incudes this:
Furthermore, the SiSM741 chipset incorporates SiS's revolutionary
HyperStreaming™ Technology, which provides multiple divided pipelines
for data, allows data to be sent concurrently, and separates data for
easier memory retrieval, resulting in a remarkable reduction in
latency versus traditional chipsets.  Has support for this been
implemented?

Also mentioned is the SiS162 wireless networking chipset.

Here is the machine I am thinking of purchasing:
http://www.bestbuy.com/site/olspage.jsp?skuId=6820728&type=product&productCategoryId=cat01174&id=1091101655872
It seems like an excellent deal.

I was considering buying this machine:
http://www.bestbuy.com/site/olspage.jsp?skuId=6825643&type=product&productCategoryId=cat01174&id=1091101643460
But, luckily, found:
http://forums.viaarena.com/categories.aspx?catid=28&flcache=4127201&entercat=y
which documents VIA's failure to support Linux.

Thanks,
            Miles
