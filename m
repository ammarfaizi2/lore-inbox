Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbVL2ISG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbVL2ISG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 03:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbVL2ISG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 03:18:06 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:60800 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932595AbVL2ISF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 03:18:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QhSISUE06Qve++qRk8cYhq3XS5vRODQuHvpldFhGjVsnNYjq4rTZ7E2ODm+zC+AerjMy9zgplybzMcvibioXdmLeZ3ikDByc+DAYgVm3txiiQJxbgKMgk889g72w8TPnv3NcgEPAO03PiGNG0K1bPZdOn4jw6iSGSh4+mVJzZgE=
Message-ID: <84144f020512290018q189b0e34pc5cba9b251a8914b@mail.gmail.com>
Date: Thu, 29 Dec 2005 10:18:03 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH 5 of 20] ipath - driver core header files
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <2d9a3f27a10c8f11df92.1135816284@eng-12.pathscale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <patchbomb.1135816279@eng-12.pathscale.com>
	 <2d9a3f27a10c8f11df92.1135816284@eng-12.pathscale.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

On 12/29/05, Bryan O'Sullivan <bos@pathscale.com> wrote:
> +/*
> + * Copy routine that is guaranteed to work in terms of aligned 32-bit
> + * quantities.
> + */
> +void ipath_dwordcpy(uint32_t *dest, uint32_t *src, uint32_t ndwords);

Wasn't this supposed to be killed?

                         Pekka
