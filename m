Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268055AbUHVSNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268055AbUHVSNo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 14:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268056AbUHVSNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 14:13:44 -0400
Received: from pop3.infonegocio.com ([213.4.129.150]:16123 "EHLO
	telesmtp4.mail.isp") by vger.kernel.org with ESMTP id S268055AbUHVSNn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 14:13:43 -0400
From: Unai Garro <ugarro@telefonica.net>
To: linux-kernel@vger.kernel.org
Subject: Re: RTL-8139 Network card slow down on 2.6.8.1-mm
Date: Sun, 22 Aug 2004 20:11:34 +0200
User-Agent: KMail/1.6.82
References: <200408221850.34538.ugarro@telefonica.net>
In-Reply-To: <200408221850.34538.ugarro@telefonica.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408222011.34791.ugarro@telefonica.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> This should fix it:
> 
> 
http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.8-rc4-mm1/8139too-mm-revert.patch
> http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.8-rc4-mm1/8139too-10.patch
> http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.8-rc4-mm1/8139too-20.patch

Yes, that seems to work just fine now. Thanks for the quick response

 Unai
