Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVAHPjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVAHPjc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 10:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVAHPjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 10:39:32 -0500
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:18175 "EHLO
	puil.ghetto") by vger.kernel.org with ESMTP id S261190AbVAHPjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 10:39:24 -0500
Date: Sat, 8 Jan 2005 16:37:57 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 0/4][RFC] Genetic Algorithm Library
Message-ID: <20050108153757.GA5972@larroy.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050106100844.53a762a0@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050106100844.53a762a0@localhost>
User-Agent: Mutt/1.5.6+20040907i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

>From a quick look I've seen your algorithm tends to converge to a global
optimum, but also as William Lee Irwin III has commentend on irc, it
might miss "special points" since there's no warranty of the function to
minize to be continuous.

I think it's a good idea to introduce this techniques to tune the
kernel, but perhaps userland would be the right place for them, to be
able to switch them off when in need or have more controll over them.
But it's a nice initiative in my opinion.

Regards.

-- 
Pedro Larroy Tovar | Linux & Network consultant |  pedro%larroy.com 
Make debian mirrors with debian-multimirror: http://pedro.larroy.com/deb_mm/
	* Las patentes de programación son nocivas para la innovación * 
				http://proinnova.hispalinux.es/
