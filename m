Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbTBATHT>; Sat, 1 Feb 2003 14:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbTBATHT>; Sat, 1 Feb 2003 14:07:19 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:23562 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id <S264954AbTBATHT>;
	Sat, 1 Feb 2003 14:07:19 -0500
Date: Sat, 1 Feb 2003 20:16:27 +0100
From: romieu@fr.zoreil.com
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: NETIF_F_SG question
Message-ID: <20030201201627.A25670@electric-eye.fr.zoreil.com>
References: <004701c2ca03$cb467460$020120b0@jockeXP> <3E3C0684.4010806@pobox.com> <005701c2ca21$9c1d90b0$020120b0@jockeXP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <005701c2ca21$9c1d90b0$020120b0@jockeXP>; from Joakim.Tjernlund@lumentis.se on Sat, Feb 01, 2003 at 07:42:01PM +0100
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joakim Tjernlund <Joakim.Tjernlund@lumentis.se> :
[...]
> Surley the copy operation will cost something?   

Cost is hidden while checksumming.

--
Ueimor
