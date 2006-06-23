Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932734AbWFWAhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbWFWAhs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 20:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbWFWAhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 20:37:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:22502 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932734AbWFWAhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 20:37:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=l0e9vfii2RXHrYr7F0tdXFuqvGXztffADwmnS2jwSapTg1KcL62kW8O1mWFHh6A84Eq+fu0ail73UICuMMCkADqACE2JwIcabUYdjuEkYxgkaRxxqe3xixSQyc65scbZkrjFcmMWPn4uiBYTdSXY/V62Wzy/udFgnklUFA2tUlo=
Message-ID: <88ee31b70606221737w4ec118e5i3db5e5e253cf3e43@mail.gmail.com>
Date: Fri, 23 Jun 2006 09:37:45 +0900
From: "Jerome Pinot" <ngc891@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Empty file in kernel source
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The last git commit (0dad31d2da706ef114bc5c21123123be2f405d5b) let one
empty file:
./sound/ppc/toonie.c

This should be removed, no ?

-- 
Jerome Pinot
http://ngc891.blogdns.net/
