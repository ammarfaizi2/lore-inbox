Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264962AbUE2OqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264962AbUE2OqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 10:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbUE2OqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 10:46:09 -0400
Received: from eta.fastwebnet.it ([213.140.2.50]:225 "EHLO eta.fastwebnet.it")
	by vger.kernel.org with ESMTP id S264962AbUE2Op6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 10:45:58 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
To: Artemio <theman@artemio.net>
Subject: Re: error compiling linux-2.6.6
Date: Sat, 29 May 2004 16:46:55 +0200
User-Agent: KMail/1.6.2
References: <200405291424.43982.theman@artemio.net> <200405291620.49602.theman@artemio.net>
In-Reply-To: <200405291620.49602.theman@artemio.net>
Cc: "Linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405291646.55856.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 May 2004 15:21, you wrote:
> I am continuing my tries...
>
> GCC 2.96, linux-2.6.6.
> ...
>
> Am I doing something wrong? :-(

YES, you are using a very BUGGY gcc version!
Try 2.95.x (x >= 3) or go to 3.x.x.

I'm using GCC 3.3.3 without any problem.

>
>
> Artemio.

Bye

-- 
	Paolo Ornati
	Linux v2.6.7-rc1-mm1
