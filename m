Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbTD3PGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbTD3PGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:06:36 -0400
Received: from franka.aracnet.com ([216.99.193.44]:16545 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262245AbTD3PGg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:06:36 -0400
Date: Wed, 30 Apr 2003 08:18:28 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Wojciech Sobczak <Wojciech.Sobczak@comarch.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: IBM x440 problems on 2.4.20 to 2.4.20-rc1-ac3
Message-ID: <4360000.1051715907@[10.10.2.4]>
In-Reply-To: <021501c30f27$e02be4a0$b312840a@nbsobczak>
References: <01d601c30f17$f3ffadf0$b312840a@nbsobczak>
 <3270000.1051712524@[10.10.2.4]> <021501c30f27$e02be4a0$b312840a@nbsobczak>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> SuSE works well, at least the SLES edition does.
> 
> but shoudn't it be platform independent? this is only kernel or meaby i
> need new gcc... or meaby something else?....

You need the kernel itself. It's the apic handling that's mostly different.

M.

