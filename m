Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTGATXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 15:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTGATXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 15:23:11 -0400
Received: from ext-nj2gw-5.online-age.net ([64.14.56.41]:34300 "EHLO
	ext-nj2gw-5.online-age.net") by vger.kernel.org with ESMTP
	id S263319AbTGATXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 15:23:10 -0400
Message-ID: <A9D3E503844A904CB9E42AD008C1C7FDBA9BD6@vacho3misge.cho.ge.com>
From: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
To: "'G. C.'" <gpc01532@hotmail.com>, linux-kernel@vger.kernel.org
Subject: RE: How to Avoid GPL Issue
Date: Tue, 1 Jul 2003 15:36:40 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We are trying to port a third party hardware driver into Linux kernel and 
> this third party vendor does not allow us to publish the source code. Is 
> there any approach that we can avoid publicizing the third party code
while 
> porting to Linux? Do we need to write some shim layer code in Linux kernel

> to interface the third party code? How can we do that? Is there any
document 
> or samples?

It depends on what you intend to do with your port. If it is only for
internal use (you will not distribute the ported code in any form)
then you may not be required to supply the source code to anyone. This is
a common interpretation of the GPL (although I can not find explicit
language providing for this interpretation in the license).

