Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVAIQ2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVAIQ2k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 11:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVAIQ2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 11:28:40 -0500
Received: from av2-1-sn3.vrr.skanova.net ([81.228.9.107]:61315 "EHLO
	av2-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261583AbVAIQ2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 11:28:38 -0500
Message-ID: <41E15BB3.3030301@fulhack.info>
Date: Sun, 09 Jan 2005 17:28:35 +0100
From: Henrik Persson <root@fulhack.info>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041203)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Breno Silva Pinto <breno@kalangolinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch to uselib()
References: <003f01c4f65e$9e4f91b0$b0e0a7c8@rootcon4qag3k5>
In-Reply-To: <003f01c4f65e$9e4f91b0$b0e0a7c8@rootcon4qag3k5>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Breno Silva Pinto wrote:
> Hi all,
> 
> Is there a patch to uselib() bug ->
> http://www.isec.pl/vulnerabilities/isec-0021-uselib.txt ?

It's patched in 2.4.29-rc1 and 2.6.10-ac6. A patch for 2.4 can also be 
found here: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=110514006004261&w=2

and for 2.6:
http://marc.theaimsgroup.com/?l=linux-kernel&m=110512844202355&w=2

Browsing the archives usually gives you alot of answers, you know. ;)

--
Henrik Persson
