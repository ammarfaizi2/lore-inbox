Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWDHPpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWDHPpQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 11:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWDHPpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 11:45:15 -0400
Received: from [4.79.56.4] ([4.79.56.4]:8612 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S964994AbWDHPpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 11:45:14 -0400
Subject: Re: 40% IDE performance regression going from FC3 to FC5 with same
	kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5a4c581d0604080834k7961aff5l7794b8893325a90c@mail.gmail.com>
References: <5a4c581d0604080747w61464d48k5480391d98b2bc47@mail.gmail.com>
	 <5a4c581d0604080834k7961aff5l7794b8893325a90c@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 08 Apr 2006 17:45:12 +0200
Message-Id: <1144511112.2989.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Just for the record - no, even rebuilding same kernel with same GCC
>  (3.4.4) under FC5, disk performance is much slower than FC3 -
>  according to hdparm _and_ dd tests.

what happens if you kill hald and other inotify using animals?


