Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318433AbSGYLz2>; Thu, 25 Jul 2002 07:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318436AbSGYLz2>; Thu, 25 Jul 2002 07:55:28 -0400
Received: from [195.63.194.11] ([195.63.194.11]:41224 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318433AbSGYLz1>; Thu, 25 Jul 2002 07:55:27 -0400
Message-ID: <3D3FE6B8.5080406@evision.ag>
Date: Thu, 25 Jul 2002 13:53:28 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: martin@dalecki.de, Vojtech Pavlik <vojtech@suse.cz>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/CFT] cmd640 irqlocking fixes
References: <Pine.LNX.4.10.10207250342410.4719-200000@master.linux-ide.org>	 <1027601555.9489.57.camel@irongate.swansea.linux.org.uk> <1027602528.9488.68.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Martin this patch should do the job. It uses the correct pci_config_lock
> and it also adds the 2.4 probe safety checks for deciding which pci
> modes to use.

I'm sure it does the job indeed ;-).

Thanks - I will include it in the next spin.

