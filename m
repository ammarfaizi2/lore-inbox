Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265967AbUAKTru (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 14:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265968AbUAKTru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 14:47:50 -0500
Received: from elpis.telenet-ops.be ([195.130.132.40]:15756 "EHLO
	elpis.telenet-ops.be") by vger.kernel.org with ESMTP
	id S265967AbUAKTrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 14:47:11 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Krisztian VASAS <iron@ironiq.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 and UML
Date: Sun, 11 Jan 2004 20:47:05 +0100
User-Agent: KMail/1.5.4
References: <1073849631.1233.8.camel@kian.localdomain>
In-Reply-To: <1073849631.1233.8.camel@kian.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200401112047.05223.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 January 2004 20:33, Krisztian VASAS wrote:
> Hello all!
>
> Is there any way to get work the 2.6 kernel with UML?
>
>
> With 2.4.24 and all of the 2.4 kernels UML works, but with all of the
> new 2.6 kernels it doesn not...

This question was asked fairly recently. Look at the usermodelinux website at 
http://usermodelinux.org and checkout the FAQ item:

http://usermodelinux.org/modules.php?name=News&file=categories&op=newindex&catid=15

which mentions a patch to be applied for 2.6.

Jan
-- 
You own a dog, but you can only feed a cat.

