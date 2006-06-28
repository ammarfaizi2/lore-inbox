Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423310AbWF1MPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423310AbWF1MPR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 08:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423308AbWF1MPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 08:15:17 -0400
Received: from ranger.systems.pipex.net ([62.241.162.32]:55748 "EHLO
	ranger.systems.pipex.net") by vger.kernel.org with ESMTP
	id S1161289AbWF1MPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 08:15:15 -0400
Date: Wed, 28 Jun 2006 13:16:05 +0100 (BST)
From: Tigran Aivazian <tigran_aivazian@symantec.com>
X-X-Sender: tigran@ezer.homenet
To: Greg KH <greg@kroah.com>
Cc: Shaohua Li <shaohua.li@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       "Van De Ven, Adriaan" <adriaan.van.de.ven@intel.com>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [PATCH]microcode update driver rewrite - takes 2
In-Reply-To: <20060627060214.GA27469@kroah.com>
Message-ID: <Pine.LNX.4.61.0606281314540.2634@ezer.homenet>
References: <1151376693.21189.52.camel@sli10-desk.sh.intel.com>
 <20060627060214.GA27469@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006, Greg KH wrote:
>> 3. add a new attribute 'pf' to help tools check if CPU has latest ucode
>
> What does "pf" stand for?

processor flags.

Kind regards
Tigran
