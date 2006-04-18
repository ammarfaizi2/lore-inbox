Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWDROrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWDROrx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 10:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWDROrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 10:47:53 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:33425 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932211AbWDROrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 10:47:53 -0400
Date: Tue, 18 Apr 2006 15:44:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt] Remove double history
Message-ID: <20060418134408.GA12153@elte.hu>
References: <200604181425.k3IEPTAC027793@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604181425.k3IEPTAC027793@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> 	Assuming you don't want it in there twice .

indeed - applied.

	Ingo
