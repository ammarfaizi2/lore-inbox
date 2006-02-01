Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbWBAMcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWBAMcT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWBAMcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:32:19 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:2737 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932431AbWBAMcR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:32:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lesh+5rE4CVgBiNo1Fif0Yuw1ZIm/AUkjTWyTSvi4cUsOy/2IICCdUT0nWFJgsWNC2CkHTAdTay2vrfzCtq8VdA7S85fzvcyaZYzyiSRKG9N+K1W+O+YlnH6u0UaGd6t1PGJVfmU/DPHivENvOTpV6X2SRpbRNardi2QHCUSDr4=
Message-ID: <84144f020602010432p51ff7a9cq1dd6654bd04f36a4@mail.gmail.com>
Date: Wed, 1 Feb 2006 14:32:14 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060201113711.6320.42205.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <20060201113711.6320.42205.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> Suspend2 uses a strong internal API to separate the method of determining
> the content of the image from the method by which it is saved. The code for
> determining the content is part of the core of Suspend2, and
> transformations (compression and/or encryption) and storage of the pages
> are handled by 'modules'.

[snip]

> Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
>
>  0 files changed, 0 insertions(+), 0 deletions(-)

Uh, oh, where's the patch?

                               Pekka
