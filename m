Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbTJAH1z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 03:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTJAH1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 03:27:55 -0400
Received: from 213-152-32-80.dsl.eclipse.net.uk ([213.152.32.80]:19349 "EHLO
	affronted.org") by vger.kernel.org with ESMTP id S262036AbTJAH1y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 03:27:54 -0400
From: Paul Symons <paul@affronted.org>
Reply-To: paul@affronted.org
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: atkbd.c not recognising key on logitech cordless keyboard
Date: Wed, 1 Oct 2003 08:27:59 +0100
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200309302200.31040.paul@affronted.org> <20031001004516.GB1520@win.tue.nl>
In-Reply-To: <20031001004516.GB1520@win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310010827.59565.paul@affronted.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I do not think that scancode was associated to a keycode in a vanilla
> 2.4 kernel. So, maybe you used setkeycodes(8) or used a patched kernel?

I've had the keyboard for around a year, and I've been mostly using 
gentoo-sources kernels from Gentoo, which are certainly not vanilla kernels. 
Perhaps they had some patch applied. Though, I think I used 2.4.21 vanilla 
previous to development kernels.

> Patching also works today. The setkeycodes command is a bit broken these
> days.

I only saw the message from earlier in the day about multimedia keyboards 
after I posted, so sorry for the repetition. I think I need to do some 
reading on keycodes and scancodes. Thanks very much for your help.

Paul

