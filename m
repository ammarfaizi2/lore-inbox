Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268894AbTGTXS7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 19:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268918AbTGTXS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 19:18:58 -0400
Received: from mpdir2.jmu.edu ([134.126.12.41]:56417 "EHLO mpdir2.jmu.edu")
	by vger.kernel.org with ESMTP id S268894AbTGTXS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 19:18:56 -0400
Message-ID: <3F1B26E3.2010903@jmu.edu>
Date: Sun, 20 Jul 2003 19:33:55 -0400
From: "William M. Quarles" <quarlewm@jmu.edu>
Organization: James Madison University
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4 CPU Arch issues
References: <3F1B1E77.2020205@jmu.edu> <20030720230535.GA3708@werewolf.able.es>
In-Reply-To: <20030720230535.GA3708@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> On 07.21, William M. Quarles wrote:
> 
>>Hi,
>>
>>In the 2.4 kernel, is it possible for you to separate the Pentium II and 
>>Pentium Pro as confiugration options, as you have done for the 2.6 
>>kernel, or is it too late in the development for that?
>>
> 
> 
> Something like this ?
> 
> --- linux-2.4.21-pre5-jam1/arch/i386/config.in.orig	2003-03-07 02:52:48.000000000 +0100
> +++ linux-2.4.21-pre5-jam1/arch/i386/config.in	2003-03-07 02:57:27.000000000 +0100

Señor (or señora?) Magallon,

Thank you for writing back.  Am I to assume that this is essentially a 
working patch that I could go ahead and apply to my kernel?

Thanks a lot,
-- 
William M. Quarles

quarlewm@jmu.edu
wquarles@bucknell.edu
walrus@bellsouth.net

