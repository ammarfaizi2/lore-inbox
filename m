Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271809AbRIQQkD>; Mon, 17 Sep 2001 12:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271832AbRIQQjx>; Mon, 17 Sep 2001 12:39:53 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:13584 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S271809AbRIQQjn> convert rfc822-to-8bit; Mon, 17 Sep 2001 12:39:43 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Juan <piernas@ditec.um.es>,
        Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Subject: Re: Ext3 journal on its own device?
Date: Mon, 17 Sep 2001 18:39:10 +0200
X-Mailer: KMail [version 1.3]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BA61CC0.C9ECC8A0@ditec.um.es> <E15j19N-0006Gh-00@mrvdom03.schlund.de> <3BA62575.E14C5808@ditec.um.es>
In-Reply-To: <3BA62575.E14C5808@ditec.um.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <E15j1RG-00082a-00@mrvdom03.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But the problem is that I need to use Linux 2.2.19, and the latest Ext3
> version for that kernel is 0.0.7a, isn't it?.

good point. I am not sure if ext3 is still maintained for linux 2.2, but I 
doubt it. Andrew or Stephen should be able to answer this question.

But with 0.0.7a it is not possible to have an external journal.

greetings

Christian Bornträger
