Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVBQBHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVBQBHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 20:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbVBQBHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 20:07:06 -0500
Received: from centaur.culm.net ([83.16.203.166]:34323 "EHLO centaur.culm.net")
	by vger.kernel.org with ESMTP id S262178AbVBQBGu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 20:06:50 -0500
From: Witold Krecicki <adasi@kernel.pl>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sil_blacklist - are all those entries necessary?
Date: Thu, 17 Feb 2005 02:05:48 +0100
User-Agent: KMail/1.7
References: <200502151706.04846.adasi@kernel.pl> <200502170143.00817.adasi@kernel.pl> <4213EC86.9020108@pobox.com>
In-Reply-To: <4213EC86.9020108@pobox.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502170205.48200.adasi@kernel.pl>
X-Spam-Score: -4.9 (----)
X-Scan-Signature: fe61db08444535778152bfa43c1083d1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia czwartek 17 luty 2005 01:59, napisa³e¶:
> > is there ANY way to test if this hack is necessary for specific model of
> > a disk?
>
> You need a bus analyzer, and need to test different sizes of FIS's.  If
> all possible sizes (2048 combinations) work on your device, the
> blacklist entry is not needed.
is there any software bus analyzer? And if so, is there  
Testing-different-sizes-of-FIS's-for-dummies anywhere ?

-- 
Witold Krêcicki (adasi) adasi [at] culm.net
GPG key: 7AE20871
http://www.culm.net
