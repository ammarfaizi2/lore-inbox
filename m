Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270244AbTHLNXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 09:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270272AbTHLNXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 09:23:42 -0400
Received: from f13.mail.ru ([194.67.57.43]:32010 "EHLO f13.mail.ru")
	by vger.kernel.org with ESMTP id S270244AbTHLNXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 09:23:41 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Norbert Preining=?koi8-r?Q?=22=20?= 
	<preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 cannot mount root fs
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Tue, 12 Aug 2003 17:23:40 +0400
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19mZ7k-000LgM-00.arvidjaar-mail-ru@f13.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	cannot mount rootfs "NULL" or hdb1
> I have compile in (of course) the filesystems of my root fs (ext3)

and you have tried to add rootfstype=ext3?

-andrey

