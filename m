Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVGGA3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVGGA3z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVGGA2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 20:28:02 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:22198 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262420AbVGGA0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 20:26:05 -0400
Subject: Re: [0/48] Suspend2 2.1.9.8 for 2.6.12
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050706082230.GF1412@elf.ucw.cz>
References: <11206164393426@foobar.com>  <20050706082230.GF1412@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120696047.4860.525.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 07 Jul 2005 10:27:28 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

On Wed, 2005-07-06 at 18:22, Pavel Machek wrote:
> Is swsusp1 expected to be functional after these are applied? You
> removed *some* of its hooks, but not all, so I'm confused.

I've been thinking about this some more and wondering whether I should
just replace swsusp. I really don't want to step on your toes though.
What would you like to see happen?

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

