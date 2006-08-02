Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWHBOwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWHBOwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 10:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWHBOwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 10:52:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:5992 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751139AbWHBOw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 10:52:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J6rnuwdlO3cwxtHcWoojGMF6GOKa9RuRDNzbKfDpVGdK12bJynR6uNfux7nWzBYchcpRM6Obr+FKCQQZkwDUImD9Vbbh1n1A6JIUdrc3195FeyuERVODX3AdpkB+Mf6pTu76urtT/jz9Bg0msUNyPYhpBM36oDv/85+2Jwteq+s=
Message-ID: <6bffcb0e0608020752h3a10e153id9561935a024cd09@mail.gmail.com>
Date: Wed, 2 Aug 2006 16:52:27 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catherine Zhang" <cxzhang@watson.ibm.com>
Subject: Re: [Patch] kernel memory leak fix for af_unix datagram getpeersec patch
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jmorris@namei.org,
       sds@tycho.nsa.org, davem@davemloft.net, catalin.marinas@gmail.com,
       czhang.us@gmail.com
In-Reply-To: <20060802064752.GA21407@jiayuguan.watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060802064752.GA21407@jiayuguan.watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catherine,

On 02/08/06, Catherine Zhang <cxzhang@watson.ibm.com> wrote:
> Hi, all,
>
> Enclosed please find the updated patch incorporating comments from
> Stephen and Dave.

Thanks!

>
> Again thanks for your help!
> Catherine
>
> --

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
