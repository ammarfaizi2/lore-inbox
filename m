Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318475AbSGSDsI>; Thu, 18 Jul 2002 23:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318476AbSGSDsH>; Thu, 18 Jul 2002 23:48:07 -0400
Received: from dsl-65-189-106-249.telocity.com ([65.189.106.249]:51851 "EHLO
	mail.temp123.org") by vger.kernel.org with ESMTP id <S318475AbSGSDsH>;
	Thu, 18 Jul 2002 23:48:07 -0400
Date: Thu, 18 Jul 2002 23:50:59 -0400
From: Josh Litherland <fauxpas@temp123.org>
To: Brad Hards <bhards@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Keypad
Message-ID: <20020719035059.GA23151@temp123.org>
References: <20020719015232.GA20956@temp123.org> <20020719031000.GA18382@kroah.com> <20020719032008.GA22934@temp123.org> <200207191336.02403.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207191336.02403.bhards@bigpond.net.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 01:36:02PM +1000, Brad Hards wrote:

> The obvious error would be not compiling in the input layer keyboard driver (or
> not loading the module, whatever). 

Good call.  That did it, thanks.

-- 
Josh Litherland (fauxpas@temp123.org)
public key: temp123.org/fauxpas.pgp
fingerprint: CFF3 EB2B 4451 DC3C A053  1E07 06B4 C3FC 893D 9228
