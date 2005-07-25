Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVGYI5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVGYI5o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 04:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVGYI5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 04:57:43 -0400
Received: from ns.firmix.at ([62.141.48.66]:27814 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S261154AbVGYI5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 04:57:34 -0400
Subject: Re: xor as a lazy comparison
From: Bernd Petrovitsch <bernd@firmix.at>
To: Puneet Vyas <vyas.puneet@gmail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Grant Coady <lkml@dodo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42E4131D.6090605@gmail.com>
References: <Pine.LNX.4.61.0507241835360.18474@yvahk01.tjqt.qr>
	 <kis7e1d4khtde78oajl017900pmn9407u4@4ax.com>
	 <Pine.LNX.4.61.0507242342080.9022@yvahk01.tjqt.qr>
	 <42E4131D.6090605@gmail.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 25 Jul 2005 10:57:13 +0200
Message-Id: <1122281833.10780.32.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-24 at 18:15 -0400, Puneet Vyas wrote:
[...]
> I just compiled two identical program , one with "!=" and other with 
> "^". The assembly output is identical.

Hmm, which compiler and which version?
You might want to try much older and other compilers.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

