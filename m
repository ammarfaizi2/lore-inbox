Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264710AbUEJOik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264710AbUEJOik (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 10:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264715AbUEJOik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 10:38:40 -0400
Received: from host201.200-117-133.telecom.net.ar ([200.117.133.201]:23783
	"EHLO smtp.bensa.ar") by vger.kernel.org with ESMTP id S264710AbUEJOiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 10:38:04 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.6-mm1
Date: Mon, 10 May 2004 11:38:03 -0300
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040510024506.1a9023b6.akpm@osdl.org>
In-Reply-To: <20040510024506.1a9023b6.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405101138.04094.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> make-4k-stacks-permanent.patch
>   make 4k stacks permanent

I've reverted this one (nvidia crash blah blah...) but I still can't get a 
working system. The box just sits there doing -apparently- nothing.

Which other patch{,es} am I missing?

Best regards,
Norberto 
