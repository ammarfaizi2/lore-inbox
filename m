Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTLPVqs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 16:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbTLPVqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 16:46:48 -0500
Received: from pf138.torun.sdi.tpnet.pl ([213.76.207.138]:26384 "EHLO
	centaur.culm.net") by vger.kernel.org with ESMTP id S262731AbTLPVqs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 16:46:48 -0500
From: Witold Krecicki <adasi@kernel.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
Date: Tue, 16 Dec 2003 22:46:45 +0100
User-Agent: KMail/1.5.93
References: <Pine.LNX.4.10.10312161303140.2113-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10312161303140.2113-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200312162246.45240.adasi@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Tuesday 16 of December 2003 22:04, Andre Hedrick napisa³:
So, could you take a look at http://www.kernel.pl/~adasi/odd-tio.txt ?
It seems that array on write is faster than on read - I was told that it's not 
normal - OR i'm getting those results wrong.
-- 
Witold Krêcicki (adasi) adasi [at] culm.net
GPG key: 7AE20871
http://www.culm.net
