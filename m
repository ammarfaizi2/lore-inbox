Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271787AbRIQQVb>; Mon, 17 Sep 2001 12:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271777AbRIQQVV>; Mon, 17 Sep 2001 12:21:21 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:47460 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S271798AbRIQQVP> convert rfc822-to-8bit; Mon, 17 Sep 2001 12:21:15 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Juan <piernas@ditec.um.es>, linux-kernel@vger.kernel.org
Subject: Re: Ext3 journal on its own device?
Date: Mon, 17 Sep 2001 18:20:41 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <3BA61CC0.C9ECC8A0@ditec.um.es>
In-Reply-To: <3BA61CC0.C9ECC8A0@ditec.um.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <E15j19N-0006Gh-00@mrvdom03.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have been browsing the Ext3 source (version 0.0.7a), and it seems
> impossible to use a block device as an Ext3 journal. Is that true?.

As the actual version of ext3 is 0.99 you should consider an update....
It is possible to have the ext3 journal on a second device with ext3 0.95 or 
higher.

Check out http://www.uow.edu.au/~andrewm/linux/ext3/ext3-usage.html

greetings 

Christian Bornträger
