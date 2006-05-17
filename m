Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWEQQ1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWEQQ1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 12:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWEQQ1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 12:27:52 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:59109 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750744AbWEQQ1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 12:27:52 -0400
Message-ID: <446B5329.7010007@gentoo.org>
Date: Wed, 17 May 2006 17:45:29 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060509)
MIME-Version: 1.0
To: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kernel vs drivers releases?
References: <8E8F647D7835334B985D069AE964A4F7024640@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
In-Reply-To: <8E8F647D7835334B985D069AE964A4F7024640@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fortier,Vincent [Montreal] wrote:
> On the other hand many people want's to get a full stabilisation of the
> actual API... 

Not meaning to sound harsh, I think you belong in this category:

	You think you want a stable kernel interface, but you really do
	not, and you don't even know it.

See Documentation/stable_api_nonsense.txt

Daniel
