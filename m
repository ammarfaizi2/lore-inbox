Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265462AbUEZKuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbUEZKuo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 06:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUEZKuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 06:50:44 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:9479 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265462AbUEZKun convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 06:50:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Buddy Lumpkin" <b.lumpkin@comcast.net>,
       "'William Lee Irwin III'" <wli@holomorphy.com>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 13:41:10 +0300
X-Mailer: KMail [version 1.4]
Cc: <orders@nodivisions.com>, <linux-kernel@vger.kernel.org>
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org>
In-Reply-To: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200405261341.10384.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 May 2004 11:30, Buddy Lumpkin wrote:
> I have worked at large fortune 500 companies with deep pockets though, so
> this may not be the case for many. I make this point though because I think
> if it isn't the case yet, it will be in the near future as memory becomes
> even cheaper because the trend certainly exists.

"640k will be enough for anyone" ?

No. Unfortunately, userspace programs grow in size as fast
as your RAM. Because typically developers do not think
about size of their program until it starts to outgrow
their RAM.

Today, 128M RAM swapless is barely enough to run full
spectrum of apps. OpenOffice and Mozilla "lead" the pack,
followed by KDE/Gnome etc.
-- 
vda
