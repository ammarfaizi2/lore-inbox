Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbSKSP1E>; Tue, 19 Nov 2002 10:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266728AbSKSP1E>; Tue, 19 Nov 2002 10:27:04 -0500
Received: from k100-145.bas1.dbn.dublin.eircom.net ([159.134.100.145]:28688
	"EHLO corvil.com.") by vger.kernel.org with ESMTP
	id <S266718AbSKSP1D>; Tue, 19 Nov 2002 10:27:03 -0500
Message-ID: <3DDA5969.9040809@corvil.com>
Date: Tue, 19 Nov 2002 15:31:53 +0000
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josh Grebe <squash2@brokedown.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Keyboard/Mouse Locking Up On Laptop
References: <1037719215.7701.13.camel@squashlaptop>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Grebe wrote:
> Hi All,
> 
> I have a Compaq Evo n600c laptop. This unit works great while plugged
> in, but when it runs on battery power, after a couple of minutes of
> idle, the keyboard and mouse will stop responding. The BIOS is pretty
> limited in options, and doesn't have anything to adjust APM settings,
> and compiling the kernel with apm enabled or disabled also makes no
> difference.

Does disabling local APIC help?

Pádraig

