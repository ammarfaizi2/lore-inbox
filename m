Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266612AbVBEQYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266612AbVBEQYF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 11:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266636AbVBEQYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 11:24:05 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:27588 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S266925AbVBEQYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 11:24:02 -0500
Message-ID: <4204F31E.5060702@drzeus.cx>
Date: Sat, 05 Feb 2005 17:23:58 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: PNP and suspend/resumt
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How is suspend/resume handled with PNP devices? There are no 
suspend/resume functions registered for the pnp bus type.

Rgds
Pierre
