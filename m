Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbVHSVqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbVHSVqY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbVHSVqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:46:24 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:13917 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965153AbVHSVqX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:46:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D/q5JmYdAH3lE06xdcYOXIf2zx6Er3AgnWQGppTQxuJz70xl7Fvhd2xut2f6eJ02qViCLESvQpz1cmverV/NqSN93QbIabSN7MNk/9iNjiO4K06mGHWKsCPxAUGIIt+7xa+QA/zKnNygDmcL/Jn1mmQi+/BSmwbrGv5+lzDVrhw=
Message-ID: <84144f02050819144660238be4@mail.gmail.com>
Date: Sat, 20 Aug 2005 00:46:22 +0300
From: Pekka Enberg <penberg@gmail.com>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Subject: Re: [Documentation] Use doxygen or another tool to generate a documentation ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050819213447.GA9538@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050819213447.GA9538@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/05, Stephane Wirtel <stephane.wirtel@belgacom.net> wrote:
> I don't know if there is a project based on Doxygen to make
> (or generate) a documentation of the kernel.
> 
> Do you think that will be interesting to make a such document ?

The kernel already has it's own API documentation generator called
kerneldoc. See the file Documentation/kernel-doc-nano-HOWTO.txt for
details.

                      Pekka
