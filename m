Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266297AbUFPNBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266297AbUFPNBH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 09:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266290AbUFPNAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 09:00:34 -0400
Received: from mail.gmx.de ([213.165.64.20]:46208 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266292AbUFPM7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 08:59:46 -0400
X-Authenticated: #4512188
Message-ID: <40D04439.5080100@gmx.de>
Date: Wed, 16 Jun 2004 14:59:37 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040604)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stairacse scheduler v6.E for 2.6.7-rc3
References: <1087333441.40cf6441277b5@vds.kolivas.org>
In-Reply-To: <1087333441.40cf6441277b5@vds.kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Here is an updated version of the staircase scheduler. I've been trying to hold
> off for 2.6.7 final but this has not been announced yet. Here is a brief update
> summary.

Hi, does this resolve the issue with ut2004? (Or is another setting for 
it needed?) I haven't tried myself, but others reported that setting 
interactive to 0 didn't help, nor giving ut2004 more priority via (re)nice.

Thanx,

Prakash
