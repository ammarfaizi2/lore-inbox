Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUEKLk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUEKLk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 07:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUEKLk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 07:40:56 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:21195 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S263062AbUEKLkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 07:40:55 -0400
From: Duncan Sands <baldrick@free.fr>
To: Nuno Ferreira <nuno.ferreira@graycell.biz>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 Oops disconnecting speedtouch usb modem
Date: Tue, 11 May 2004 13:40:52 +0200
User-Agent: KMail/1.5.4
References: <1084274778.2262.7.camel@taz.graycell.biz>
In-Reply-To: <1084274778.2262.7.camel@taz.graycell.biz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405111340.52107.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> May 10 23:31:57 taz kernel: EIP is at destroy_async+0x54/0x80

Does this happen with -mm1?

Thanks,

Duncan.
