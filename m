Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbVCJLxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbVCJLxb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 06:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVCJLxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 06:53:30 -0500
Received: from h4.net39.bmstu.ru ([195.19.39.4]:19184 "EHLO
	xantippe.fb12.tu-berlin.de") by vger.kernel.org with ESMTP
	id S262524AbVCJLxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 06:53:24 -0500
From: JustMan <justman@e1.bmstu.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11] fix call kobject_get_path() with zero kobject argument  in drivers/base/class.c
Date: Thu, 10 Mar 2005 14:53:18 +0300
User-Agent: KMail/1.7.2
References: <000a01c519ca$301a10f0$4f00a8c0@kachmar> <200503100349.41469.justman@e1.bmstu.ru>
In-Reply-To: <200503100349.41469.justman@e1.bmstu.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503101453.19037.justman@e1.bmstu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The attached patch fix call kobject_get_path() with zero kobject argument.

I'm sorry. My  previous patch was incorrect.

-- 
Regards, JustMan.
