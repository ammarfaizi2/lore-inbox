Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVIMV7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVIMV7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVIMV7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:59:35 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:14270 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932132AbVIMV7e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:59:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JJQqAr7dsSF+wCPJNmK5hkEC9CQG+HbZh2aEMNoxhnDwImcQF79gy8ra+MdLPWfBLcBQeSkKoufGs24mCgHtNeyVPmzAWdHQmeGifE6MCNExkuFMYq8CiygarnysRYhwREAJsEUzBIEkzbQqWG5lH3gz5Gl4uz4j43Fm60SwGII=
Message-ID: <2ac89c70050913145926583918@mail.gmail.com>
Date: Wed, 14 Sep 2005 01:59:30 +0400
From: Dmitrij Bogush <dmitrij.bogush@gmail.com>
Reply-To: dmitrij.bogush@gmail.com
To: linux-kernel@vger.kernel.org
Subject: snd-via82xx-modem do not work from 2.6.12 kernel version
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to get MC97 modem working with 2.6.14-rc1 and get "NO DIAL
TONE". I think that something wrong with driver source, becouse if
replace snd-via82xx-modem.c with 2.6.11 version and recompile modules
all works fine..

This is on "Acer Aspire 1524" laptop.

-- 
Best Regards,
Dmitrij A Bogush.
