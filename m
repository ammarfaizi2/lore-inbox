Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbVJ2NBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbVJ2NBM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 09:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbVJ2NBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 09:01:12 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:54920 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750810AbVJ2NBM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 09:01:12 -0400
Subject: Multiple MODULE_AUTHOR statements
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 29 Oct 2005 15:01:13 +0200
Message-Id: <1130590873.5396.2.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I saw some people adding multiple MODULE_AUTHOR statements to their
drivers if they wanna mention more than one author. I normally used a
comma separated list. Is it valid to use multiple statements? If yes,
then I will change my drivers to use the same approach.

Regards

Marcel


