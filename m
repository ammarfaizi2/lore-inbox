Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbUKQWkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbUKQWkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbUKQWil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:38:41 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:29069 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262579AbUKQWgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:36:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=s5QVrgMHuGtuEhWghRa7VWKKMBgL95C6a9rOZIKhTbo721aMy7Cw+tAZSPZp4czvkMRwlm6358Be8f+Qbb6sXrxLMpfA+k3s+H+cbdgVp/Okb22DjGyPY0I+oe5yTo7fDvxhFNtftXrBuJkF+wu4NiOa7S8Akjf5P2kutHsPkAg=
Message-ID: <58cb370e04111714366d1ce656@mail.gmail.com>
Date: Wed, 17 Nov 2004 23:36:45 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] small IDE cleanups
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041107023336.GC14308@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041107023336.GC14308@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Nov 2004 03:33:36 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> The patch below does the following small cleanups in the IDE code:
> - make some needlessly global code static
> - remove two unused functions from pdc202xx_new.c
> 
> Please review and apply if it's correct.

applied
