Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265160AbUAJNNN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 08:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUAJNNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 08:13:12 -0500
Received: from [218.93.20.101] ([218.93.20.101]:46799 "EHLO mail.shinco.com")
	by vger.kernel.org with ESMTP id S265160AbUAJNNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 08:13:12 -0500
Date: Sat, 10 Jan 2004 21:13:00 +0800
From: Peng Yong <ppyy@bentium.com>
To: Peng Yong <ppyy@bentium.com>, linux-kernel@vger.kernel.org
Subject: Re: system resource limit in kernel 2.6
In-Reply-To: <20040110110711.GB29693@wiggy.net>
References: <20040110104249.076E.PPYY@bentium.com> <20040110110711.GB29693@wiggy.net>
Message-Id: <20040110211058.8EE9.PPYY@bentium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Previously Peng Yong wrote:
> > httpd.conf:
> 
> Apache does not commonly run a process as the nobody user (uid 65534) so
> it is most likely another process on your server.

we compiled the apache from source instead of using binary package from
debian. the apache process was runned as nobody user.

--
Peng Yong                     Email: ppyy@staff.cn99.com
Bentium Ltd.                  URL: http://www.cn99.com

