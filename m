Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbWEXBXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbWEXBXl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 21:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWEXBXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 21:23:41 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:39897 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S932528AbWEXBXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 21:23:41 -0400
Subject: Re: Query regarding _etext, _edata, _end.
From: Arjan van de Ven <arjan@infradead.org>
To: vamsi krishna <vamsi.krishnak@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3faf05680605231804q5aa8d65fqeb02026dd1515876@mail.gmail.com>
References: <3faf05680605231804q5aa8d65fqeb02026dd1515876@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 24 May 2006 03:23:38 +0200
Message-Id: <1148433818.3049.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If yes , will these be always supported in the newer kernels coming in future?


that's doubtful; there is no such guarantee of any kind of kernel
internals in linux... I don't see these being any kind of special
exception.

you made me curious... what do you want to use these for?

