Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264349AbUEaF7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264349AbUEaF7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 01:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUEaF7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 01:59:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:44996 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264349AbUEaF7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 01:59:13 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1, 3com still broken after resume
Date: Mon, 31 May 2004 07:59:06 +0200
User-Agent: KMail/1.6.2
Cc: David Ford <david+challenge-response@blue-labs.org>
References: <40BAB8D9.2080705@blue-labs.org>
In-Reply-To: <40BAB8D9.2080705@blue-labs.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405310759.10963.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> May 30 21:37:39 powerix PM: Preparing system for suspend
[error messages]

Which 3com driver fails? 3c59x?

Have you checked this patch?

http://marc.theaimsgroup.com/?l=linux-kernel&m=108591456410688&w=2

If it helps, you should report back.

cheers

Christian
