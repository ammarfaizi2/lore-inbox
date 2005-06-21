Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVFUBqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVFUBqO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 21:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVFUBoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 21:44:17 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:48247 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261777AbVFUBko convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 21:40:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LBUJaf9oJY3V9xAdZu4grICfX6w+iQk6UF1agFg/CCQK1zOFZFq6nAU0M1gob8dpfysKlFguybPq3U+CGCmw2exB81wRXTul8/TWsWEZ0zx9kN8bkOA5iHLLfi8jGg0F+jjhZfI8a1Zv8cGt2pigPdflW7QM5Os5ChFhCdR5TA4=
Message-ID: <d73ab4d005062018407540171b@mail.gmail.com>
Date: Tue, 21 Jun 2005 09:40:41 +0800
From: guorke <gourke@gmail.com>
Reply-To: guorke <gourke@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: make install error(grub).
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all
    I update to 2.6.12,all finished but "make install",
it is:
sh /root/test/linux-2.6.12/arch/i386/boot/install.sh 2.6.12
arch/i386/boot/bzImage System.map "/boot"
grubby fatal error: unable to find a suitable template

I asked google,and do my best to fix it ,but no answer,I think it must
be a normal question.

I wishes fix it,not  boot my latest kernel by hand. 

Thanks.
