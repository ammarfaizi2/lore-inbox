Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966205AbWK2H6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966205AbWK2H6w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 02:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966206AbWK2H6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 02:58:52 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:36067 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S966205AbWK2H6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 02:58:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ajfswwSPkTeI7VjVuch1Plvysv1UW6uw2IA6dHavXODReyKWVyArrZ9U+xQrTCxqODcT1gu3rVsGZfWhk5MYFNgk2elJUrHEe19G+24s1zUGcmue/AuMAlAY1cc1Jh4HgAA2u0BU4jOyNhX0f6k2SydTPuhLUC9vaJjCZPSvi6g=
Message-ID: <e9010580611282358p5966357cxf50c650819ba1710@mail.gmail.com>
Date: Wed, 29 Nov 2006 13:28:50 +0530
From: "prajakta choudhari" <prajaktachoudhari@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Help for kernel module programming
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
I am writing a kernel module for assging an ip address to an interface.
I  have included linux/igmp.h but still whenever i use the function
declared in  igmp.h file, it says unresolved symbol for that function.
I am new to this programming.
i use the following command to compile it:
gcc -c -D__KERNEL__   -DMODULE
-I/home/newkernelsource/linux-2.4.22/include  hello.c
-- 
-------------------------------------
-------------------------------------
Regards,
Prajakta Choudhari,
Project Engineer,
Networking and Internet Software Group,
CDAC,Pune
Email:prajaktac@cdac.in
Mobile:9890302701
