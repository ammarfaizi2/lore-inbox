Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265143AbUADF4H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 00:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265147AbUADF4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 00:56:07 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:44230 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S265143AbUADF4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 00:56:05 -0500
Date: Sat, 03 Jan 2004 21:55:43 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ananda Bhattacharya <anandab@cabm.rutgers.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Pentium 4 HT SMP
Message-ID: <2840000.1073195743@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0401032330270.16379-100000@puma.cabm.rutgers.edu>
References: <Pine.LNX.4.44.0401032330270.16379-100000@puma.cabm.rutgers.edu>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I was wondering if one compiles a kernel for a 
> Pentium 4 which has HyperThreading will we need to recompile 
> SMP support for a single physical CPU or will one need to 
> have SMP enabled to take advantag of hyperthreading.

You need SMP.

M.

