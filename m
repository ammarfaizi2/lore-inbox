Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272278AbTG3VOR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272279AbTG3VOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:14:17 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:2293 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S272278AbTG3VOQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:14:16 -0400
Subject: Re: Warn about taskfile?
From: Robert Love <rml@tech9.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030730205935.GA238@elf.ucw.cz>
References: <20030730205935.GA238@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1059600104.931.207.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-5) 
Date: 30 Jul 2003 14:21:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-30 at 13:59, Pavel Machek wrote:
 
> -	  It is safe to say Y to this question, in most cases.
> +	  It is safe to say Y to this question, but you should attach
> +	  scratch monkey, first.

What is 'scratch monkey' ? ;-)

If it is truly unsafe, perhaps we should just say so.

	Robert Love


