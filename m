Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTJALrj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 07:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTJALrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 07:47:39 -0400
Received: from [217.70.17.156] ([217.70.17.156]:21266 "EHLO mail.rusbiz.com")
	by vger.kernel.org with ESMTP id S262013AbTJALrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 07:47:39 -0400
Subject: RE:Re: How to use module in 2.6
From: ocsy <ocsy@yandex.ru>
Reply-To: ocsy@yandex.ru
To: linux-kernel@vger.kernel.org
In-Reply-To: <slrnbnlem5.566.usenet.2117@home.andreas-s.net>
References: <1065006634.1144.39.camel@ocsy>
	 <slrnbnlem5.566.usenet.2117@home.andreas-s.net>
Content-Type: text/plain
Message-Id: <1065009240.1144.46.camel@ocsy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 01 Oct 2003 15:54:00 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes i make it))Kernel comile and modules was done (make modules after
that make modules_install)And than reboot....
But after that I type insmod <module_name> and I see on a screen a
LITTLE warning (fatal error) that talk to me module can be load to the
kernel becouse it have old format))
I think than I must look for modutils (witch can support kernell 2.6 new
modules format) but I can't find it...


