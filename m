Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbVINJeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbVINJeD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbVINJeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:34:03 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:1165 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965113AbVINJeB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:34:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XpdW5zQ2Jk1ccz6Vy1W3jmXVNI0Jd3JqixoRPDjPTeWrr82V8NIYFDYW0Srw6x/JcbhRM8aZEw6DPBFoPfW+R4yy6txfUkNOZqc4/y8D2MF5UANdf8j/4WXLRQCb14lqPDguKILekrkAE9oZMylFODIFyZHAd2hsbzxOU8pgLz4=
Message-ID: <2cd57c9005091402337fee047d@mail.gmail.com>
Date: Wed, 14 Sep 2005 17:33:57 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@gmail.com
To: Andrew Morton <akpm@osdl.org>
Subject: suggest mm-commits subjects
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to suggest mm-commits subjects in these forms:

[added] foo.patch added to -mm tree
[removed] foo.patch removed from -mm tree

or

[A] foo.patch added to -mm tree
[R] foo.patch removed from -mm tree
-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
