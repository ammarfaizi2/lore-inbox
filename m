Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWCTKAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWCTKAm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 05:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWCTKAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 05:00:42 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:36158 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932089AbWCTKAm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 05:00:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KJTawRk0ydrPGu8XtCqmR5RKK/YmL6F6ISF1Z0082FptmAO/dSGFu9B/mf57Qu1U449GVvmdvibl27AeEUusM1dpS6fciRom/iAXJVWLw1VqaKlPjqLWrI2SKoanyB8nQqu6spBX0GUfhsjR1se0mOpIhXIo1VZubaVvG6KlDkU=
Message-ID: <489ecd0c0603200200va747a68k187651930a3f0a51@mail.gmail.com>
Date: Mon, 20 Mar 2006 18:00:41 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 1/2]Blackfin archtecture patche for 2.6.16
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

   This is the Blackfin archtecture patch for kernel 2.6.16.  This
patch include header files and arch files, which are hard to split. 
Thus the patch size is big, I hope that is OK for a new architecture
patch. For the other driver patches, I'll send them one by one in
small size. Thanks!

  Because of the big size, I put it here:
http://blackfin.uclinux.org/frs/download.php/810/blackfin-arch.patch.tar.bz2

Signed off by: Luke Yang <luke.adi@gmail.com>

--
Best regards,
Luke Yang
magic.yyang@gmail.com; luke.adi@gmail.com
