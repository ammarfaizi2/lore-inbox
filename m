Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbVILORd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVILORd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbVILORd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:17:33 -0400
Received: from host62-24-231-115.dsl.vispa.com ([62.24.231.115]:57475 "EHLO
	orac.walrond.org") by vger.kernel.org with ESMTP id S1751002AbVILORc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:17:32 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm3
Date: Mon, 12 Sep 2005 15:17:31 +0100
User-Agent: KMail/1.8.2
References: <20050912024350.60e89eb1.akpm@osdl.org>
In-Reply-To: <20050912024350.60e89eb1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509121517.31562.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 September 2005 10:43, Andrew Morton wrote:

>   - An update to the anticipatory scheduler to fix a performance problem
>     where processes do a single read then exit, in the presence of
> competing I/O acticity.

Is there more discussion on this somewhere? When was the problem introduced? 
Bit of a long shot, but it fits the description of some problems I have 
noticed recently.

Andrew Walrond
