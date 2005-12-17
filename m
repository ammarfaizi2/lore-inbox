Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVLQK07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVLQK07 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 05:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVLQK07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 05:26:59 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:30403 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S932419AbVLQK06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 05:26:58 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: remove CONFIG_UID16
To: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sat, 17 Dec 2005 11:28:18 +0100
References: <5kCbe-45z-7@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EnZIZ-0003Px-3c@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:

> It seems noone noticed that CONFIG_UID16 was accidentially always
> disabled in the latest -mm kernels.
> 
> Is there any reason against removing it completely?

Maybe embedded systems.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
