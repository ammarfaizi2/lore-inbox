Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264191AbUEMNmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264191AbUEMNmh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 09:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUEMNmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 09:42:37 -0400
Received: from ms003msg.fastwebnet.it ([213.140.2.42]:17134 "EHLO
	ms003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S264191AbUEMNls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 09:41:48 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.6-mm2
Date: Thu, 13 May 2004 15:42:23 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040513032736.40651f8e.akpm@osdl.org>
In-Reply-To: <20040513032736.40651f8e.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405131542.23710.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 May 2004 12:27, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6
>-mm2/

  CC      kernel/module.o
kernel/module.c:730: error: redefinition of `add_attribute'
kernel/module.c:382: error: `add_attribute' previously defined here
kernel/module.c:382: warning: `add_attribute' defined but not used
make[1]: *** [kernel/module.o] Error 1
make: *** [kernel] Error 2

bye

-- 
	Paolo Ornati
	Linux v2.6.6
