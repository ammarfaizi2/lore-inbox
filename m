Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTJFIts (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 04:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbTJFIts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 04:49:48 -0400
Received: from catv-50624ad9.szolcatv.broadband.hu ([80.98.74.217]:660 "EHLO
	catv-50624ad9.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S263015AbTJFItr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 04:49:47 -0400
Message-ID: <3F812CA8.2070907@freemail.hu>
Date: Mon, 06 Oct 2003 10:49:44 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.4) Gecko/20030703
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 71MB compressed for COMPILED(!!!) 2.6.0-test6
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

turn this off:

 > CONFIG_DEBUG_INFO=y

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.

