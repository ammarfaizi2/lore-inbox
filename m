Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422675AbWJLII4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWJLII4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWJLIIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:08:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:54203 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932516AbWJLIIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:08:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=coZ4qLpHub8GTEcjP1/u8Mz63NG7GgkJdzNj9fDUw69V376z4/EkOXsIbR6GdPI4Uzcu44hvn+iJ6OBPo7HLdIWmNnW93iYqXHTJJBtkeCLj0QCBC9xZvhOx8z3WlVhcCrKTaDbUYQzEpW+TyIN9ZMKuyZyANXv/4DLn7ovjSRU=
Message-ID: <84144f020610120108s1f4b3484q158195ebeac8a214@mail.gmail.com>
Date: Thu, 12 Oct 2006 11:08:51 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Akinobu Mita" <akinobu.mita@gmail.com>
Subject: Re: [patch 3/7] fault-injection capability for kmalloc
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org,
       "Don Mullis" <dwm@meer.net>
In-Reply-To: <452df222.0804022e.60ae.67a6@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061012074305.047696736@gmail.com>
	 <452df222.0804022e.60ae.67a6@mx.google.com>
X-Google-Sender-Auth: b1741c95dc83420f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/06, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> From: Akinobu Mita <akinobu.mita@gmail.com>
>
> This patch provides fault-injection capability for kmalloc.

The slab bits look ok to me.

                                      Pekka
