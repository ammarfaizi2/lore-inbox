Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264345AbUDOQyj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 12:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUDOQyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 12:54:39 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:59146 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264345AbUDOQyh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 12:54:37 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: lenar@vision.ee
Subject: Re: poor sata performance on 2.6
Date: Thu, 15 Apr 2004 19:54:18 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200404150236.05894.kos@supportwizard.com> <200404151537.38739.vda@port.imtp.ilyichevsk.odessa.ua> <407E86A5.70700@vision.ee>
In-Reply-To: <407E86A5.70700@vision.ee>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404151954.19061.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 April 2004 15:57, Lenar Lõhmus wrote:
> Denis Vlasenko wrote:
> >27 Mb/s is not 'very' bad for 80Gb drive.
> >
> >Can you verify that drive indeed is able to do better
> >(quick test under Windows is in order)? It would be silly
> >to try to hunt down problem which do not exist.
> >
> >If problem does exist, try 2.4 kernels.
>
> This drive really _can_ do _much_ better. At least order of two. In my
> case - order of three.

I don't believe any drive can do 27000 Mb/s ;)

You probably meant 'three times more throughput', which can
very well be true.
--
vda

