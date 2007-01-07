Return-Path: <linux-kernel-owner+w=401wt.eu-S932333AbXAGCOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbXAGCOs (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 21:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbXAGCOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 21:14:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:27460 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932333AbXAGCOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 21:14:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wwh8sQZBw3OY3HwZhdmTtQJAhcgPOVCj5vSryFzAAk27JqWKEDoyBM1/PlwavTqTqA+ALNLetGEpoL2Ikm2n8NTUyNFapVepEGDTdjLoJiDW7o6gnoOiVuQ+9eMe0WF5Q/Z1c5/UlkBiVcuxMK6Zk8qbhUfK5WOc8rEHuDH6shs=
Message-ID: <58cb370e0701061814g7d37578cj6edab7f15e630348@mail.gmail.com>
Date: Sun, 7 Jan 2007 03:14:46 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Conke Hu" <conke.hu@gmail.com>
Subject: Re: [PATCH 2/3] atiixp.c: sb600 ide only has one channel
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Greg KH" <greg@kroah.com>
In-Reply-To: <5767b9100701060414j2e2385a8xcbab477bedca34b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5767b9100701060414j2e2385a8xcbab477bedca34b3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/07, Conke Hu <conke.hu@gmail.com> wrote:
> AMD/ATI SB600 IDE/PATA controller only has one channel.
>
> Signed-off-by: Conke Hu <conke.hu@amd.com>

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

[ but the patch is line wrapped ]
