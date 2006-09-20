Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWITRrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWITRrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWITRrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:47:04 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:48800 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932137AbWITRrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:47:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-archive:mime-version:content-type:sender;
        b=jyGX9d8xix4UoVyyZfAIatfJrmlQus2CVMaUEQcDzXXB9E/9+HyWgbwHOTIaBHUqidT6ltDXZ/Ns/BpA9wLPyHBBlRW3oXWVm4mLquOZgDCP3mE9qZVFxqiNQgUO0aE/byqUXdiKqzlkLaMVptYXewxfjPvPCYbCAatQcAukpEo=
Date: Wed, 20 Sep 2006 14:46:55 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <2@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: Is there an fsck for UDF ?
Message-ID: <Pine.LNX.4.64.0609201443150.13793@dyndns.pervalidus.net>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is slightly OT. I have a DVD-RAM, which I used for amost 1 
and 1/2 year, but now it reports "udf: udf_read_inode(ino 2504) 
failed !bh", and as a result I can't delete a certain file.

Is there some way to fix it without formating ? udftools has a 
non-working fsck.

-- 
How to contact me - http://www.pervalidus.net/contact.html
