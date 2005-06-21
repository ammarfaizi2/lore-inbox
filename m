Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbVFUV2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbVFUV2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbVFUV2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:28:39 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:15885 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262488AbVFUV2T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:28:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EpTLhdZU2gl0/h5EDndQ/zZN6Lf3Ao7awXmj1GiGDMoY0kpzJr+jmU1MJwXX8S3DkQ/5u33jU6dQTlE1HDJZsq99y5U9KaFlCRu8OxAgi7Xc1ESaLo34iKvmDJOugzRpqS0T1cb/jQBo2oKUHsQZpKBz1rt83pXiledbjUEyMwU=
Message-ID: <5c77e707050621142841ad3225@mail.gmail.com>
Date: Tue, 21 Jun 2005 23:28:11 +0200
From: Carsten Otte <cotte.de@gmail.com>
Reply-To: Carsten Otte <cotte.de@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: -mm -> 2.6.13 merge status
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050621132204.1b57b6ba.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
	 <42B831B4.9020603@pobox.com> <20050621132204.1b57b6ba.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/05, Andrew Morton <akpm@osdl.org> wrote:
> > and indeed vendors ARE shipping
> > other crashdump methods.
> 
> Which ones?
For 390, we ship standalone bootable crashdump tools with both sles
and rhel. As for kexec, I'd like to see a kexec based 390 bootloader
in the future which would be more flexible then our current one. So
I'd like to vote for merging kexec/kdump.
