Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757516AbWK0JNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757516AbWK0JNZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 04:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757521AbWK0JNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 04:13:25 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:45874 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1757516AbWK0JNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 04:13:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G3R2yL2UWGhJw8oqG7uRymfB+rLbBwtqC3rgUzQgWsd7BAgWvWT5CnhJ6D3+KltftyzTklafyUdC8CkqHwDZ6HBEwWWWcHvB4mSMDzkxPAUlvzVJgitDJAfDs9ysSKRaRGhn8qRDQoVEbxwck1v6IVsJCyP30AElbYfZy+cRi8I=
Message-ID: <acd2a5930611270113t266602dax49ef671aca99d4c8@mail.gmail.com>
Date: Mon, 27 Nov 2006 12:13:22 +0300
From: "Vitaly Wool" <vitalywool@gmail.com>
To: "Pierre Ossman" <drzeus-mmc@drzeus.cx>
Subject: Re: [PATCH] fix "prev->state: 2 != TASK_RUNNING??" problem on SD/MMC card removal
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4569F82E.1040207@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061123184217.a971d267.vitalywool@gmail.com>
	 <4569F82E.1040207@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/06, Pierre Ossman <drzeus-mmc@drzeus.cx> wrote:
> Hmm... I can't find any such requirement in HEAD, or 2.6.18. What kernel
> are you running?

2.6.18 + -rt patches by Ingo.

Vitaly
