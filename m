Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbTHZWgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 18:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTHZWe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 18:34:57 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:10644 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263012AbTHZWdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 18:33:37 -0400
Date: Wed, 27 Aug 2003 00:33:28 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.23-pre1] /proc/ikconfig support
Message-ID: <20030826223328.GC27422@merlin.emma.line.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0308261629400.18109@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0308261629400.18109@freak.distro.conectiva>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003, Marcelo Tosatti wrote:

> And about ikconfig, hum, I'm not sure if I want that. Its nice, yes, but I
> still wonder. You are free to convince me though: I think people usually
> know what they compile in their kernels, dont they?

Precedent: admin at a site changes, original .config was snatched from
some other machine, and kernel sources have been removed from $NOTEBOOK
because space was tight... In such cases, a config store is pretty
handy. Extract, make oldconfig, there you go.

If you're collecting user votes, count mine as AYE.

-- 
Matthias Andree
