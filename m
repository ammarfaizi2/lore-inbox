Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbUKKTrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbUKKTrv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 14:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbUKKTrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 14:47:51 -0500
Received: from pauli.thundrix.ch ([213.239.201.101]:54937 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S262317AbUKKTrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 14:47:24 -0500
Date: Thu, 11 Nov 2004 20:47:13 +0100
From: Tonnerre <tonnerre@thundrix.ch>
To: Diego <foxdemon@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Begginer need help 2.6
Message-ID: <20041111194713.GA13048@pauli.thundrix.ch>
References: <d5a95e6d041110053276820b92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5a95e6d041110053276820b92@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Salut,

On Wed, Nov 10, 2004 at 10:32:52AM -0300, Diego wrote:
> Sorry bothering but somebody can help me, i need to know if exist in
> kernel a variable ou something that can inform the CPU idle time (like
> top informs) and where is it, so i can use it.

You mean, a possibility to let a job take all CPU idle time? Set its 
prio to SCHED_BATCH.

			    Tonnerre

