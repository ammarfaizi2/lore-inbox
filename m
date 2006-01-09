Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWAIPGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWAIPGh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWAIPGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:06:36 -0500
Received: from ns2.suse.de ([195.135.220.15]:2517 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932330AbWAIPGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:06:36 -0500
From: Andi Kleen <ak@suse.de>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH] i386/x86-64: Removes 'enable_timer_pin_1' command-line option.
Date: Mon, 9 Jan 2006 16:03:13 +0100
User-Agent: KMail/1.8.2
Cc: akpm <akpm@osdl.org>, 76306.1226@compuserve.com, petero2@telia.com,
       lkml <linux-kernel@vger.kernel.org>
References: <20060109113953.2ebb56e3.lcapitulino@mandriva.com.br>
In-Reply-To: <20060109113953.2ebb56e3.lcapitulino@mandriva.com.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601091603.14050.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 January 2006 14:39, Luiz Fernando Capitulino wrote:
>  Hi,
> 
>  Commit 66759a01adbfe8828dd063e32cf5ed3f46696181 added two new command-line
> options, IIUC:

Better keep it for now in case we change the defaults again.

-Andi
