Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318095AbSGXTiX>; Wed, 24 Jul 2002 15:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318097AbSGXTiX>; Wed, 24 Jul 2002 15:38:23 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:7645 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S318095AbSGXTiW>;
	Wed, 24 Jul 2002 15:38:22 -0400
Date: Wed, 24 Jul 2002 21:41:30 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Kareem Dana <kareemy@earthlink.net>
Cc: Andrew Rodland <arodland@noln.com>, linux-kernel@vger.kernel.org
Subject: Re: loop.o device busy after umount
Message-ID: <20020724194130.GB13180@win.tue.nl>
References: <20020724145919.01c79fce.kareemy@earthlink.net> <20020724151904.3d719dea.arodland@noln.com> <20020724153319.5ebd589b.kareemy@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020724153319.5ebd589b.kareemy@earthlink.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 03:33:19PM -0400, Kareem Dana wrote:

> losetup worked like a charm. Thanks. Any reason umount would not do that automatically though?

Read mount(8), the places where losetup is mentioned.
