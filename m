Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290155AbSAWWUS>; Wed, 23 Jan 2002 17:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290156AbSAWWUI>; Wed, 23 Jan 2002 17:20:08 -0500
Received: from maild.telia.com ([194.22.190.101]:58091 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S290155AbSAWWUA>;
	Wed, 23 Jan 2002 17:20:00 -0500
Date: Wed, 23 Jan 2002 23:26:50 +0100
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: Ruben =?iso-8859-1?Q?P=FCttmann?= <ruben.puettmann@freenet-ag.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems compiling 2.4.18-pre6
Message-ID: <20020123222650.GA5005@telia.com>
Mail-Followup-To: Ruben =?iso-8859-1?Q?P=FCttmann?= <ruben.puettmann@freenet-ag.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C4F32F5.6080807@freenet-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3C4F32F5.6080807@freenet-ag.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruben Püttmann <ruben.puettmann@freenet-ag.de> wrote:

> i want test the pre 6 but I ever get this message:
> 
> drivers/sound/sounddrivers.o (.data+0xB4): undefined reference to 'local 
> symbols in discarded section .text.exit'

As a workaround, compile VIA82CXXX as a module. I'm pretty sure Andrew
Morton (?) came up with a patch for this before, but it seams it did't get
included.
-- 

André Dahlqvist <andre.dahlqvist@telia.com>

