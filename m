Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbWBTECc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbWBTECc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 23:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbWBTECc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 23:02:32 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:18049 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932602AbWBTECb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 23:02:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LofP2dlqdV0utmaN40gzEB+QSqPx577nQz1Hu3Nr5eUb7Dn3tQX9iWFi4wfPoQua0xKa9i/9oSiZTImgWWfRfvEyE/5qLYfx5iu2XlPEsCZ18Otw4s3xyhY4jwx3NM9CJTWHM2sz/zEHdA0Fgr5HqGKYSxx7PEvNYqGsEfzL2j0=
Message-ID: <993d182d0602192002n727dd0b3gf4426527dd5b61a5@mail.gmail.com>
Date: Mon, 20 Feb 2006 09:32:29 +0530
From: "Conio sandiago" <coniodiago@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Magic numbers ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I want to know about the magic numbers in the uImage of linux kernel,
I want to know how is this magic number calculated ?
I am having 2 images in the flash memory,

One is linux kernel image - which has a magic number of 0x27051956,
and second image is ramdisk,

whose magic number is also the same ,
How come this is tru?
can anyone please help.
Thanks
conio
